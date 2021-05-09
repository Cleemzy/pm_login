defmodule PmLoginWeb.Project.BoardLive do
  use Phoenix.LiveView

  alias PmLoginWeb.LiveComponent.{TaskModalLive,PlusModalLive,ModifModalLive,CommentsModalLive}

  alias PmLoginWeb.ProjectView
  alias PmLogin.Monitoring
  alias PmLogin.Kanban
  alias PmLogin.Monitoring.{Task, Priority}
  alias PmLogin.Login
  alias PmLogin.Login.User


  def mount(_params,%{"curr_user_id" => curr_user_id ,"pro_id" => pro_id}, socket) do
    if connected?(socket), do: Kanban.subscribe()
    Monitoring.subscribe()

    layout = if Monitoring.is_admin?(curr_user_id) do
      {PmLoginWeb.LayoutView, "board_layout_live.html"}
    else
      # {PmLoginWeb.LayoutView, "board_layout_live.html"}
      {PmLoginWeb.LayoutView, "contributor_board_live.html"}
    end



    project = Monitoring.get_project!(pro_id)

    task_changeset = Monitoring.change_task(%Task{})
    modif_changeset = Monitoring.change_task(%Task{})

    priorities = Monitoring.list_priorities
    list_priorities = Enum.map(priorities, fn (%Priority{} = p)  -> {p.title, p.id} end)

    contributors = Login.list_contributors
    list_contributors = Enum.map(contributors, fn (%User{} = p)  -> {p.username, p.id} end)

    {:ok, assign(socket, is_admin: Monitoring.is_admin?(curr_user_id), show_plus_modal: false,curr_user_id: curr_user_id, pro_id: pro_id,
                    contributors: list_contributors, priorities: list_priorities, board: Kanban.get_board!(project.board_id), show_task_modal: false, show_modif_modal: false,
                    task_changeset: task_changeset, modif_changeset: modif_changeset, show_comments_modal: false,
                    layout: layout)}
  end

  def handle_event("send-comment", %{"com" => content, "poster_id" => poster_id, "task_id" => task_id}, socket) do
    IO.puts task_id
    IO.puts poster_id
    IO.puts content
    Monitoring.post_comment(%{"content" => content, "task_id" => task_id, "poster_id" => poster_id})
    card_id = socket.assigns.card_with_comments.id
    {:noreply, socket |> assign(card_with_comments: Kanban.get_card_for_comment!(card_id)) |>push_event("updateScroll", %{})}
  end

  def handle_event("update_card", %{"card" => card_attrs}, socket) do
    card = Kanban.get_card!(card_attrs["id"])
    # IO.inspect card_attrs
    # IO.inspect updated_stage
    IO.inspect card
    case Kanban.update_card(card, card_attrs) do
      {:ok, _updated_card} ->
        updated_task = card.task_id |> Monitoring.get_task!
        updated_stage = card_attrs["stage_id"] |> Kanban.get_stage!
        task_attrs = %{"status_id" => updated_stage.status_id}
        IO.inspect Monitoring.update_task_status(updated_task, task_attrs)
        {_, real_task} = Monitoring.update_task_status(updated_task, task_attrs)
        # IO.inspect real_task
        # IO.inspect Monitoring.get_task!(real_task.id)
        this_board = socket.assigns.board
        {:noreply, socket |> put_flash(:info, "Tâche #{Monitoring.get_task_with_status!(real_task.id).title} mise dans \" #{Monitoring.get_task_with_status!(real_task.id).status.title} \" ") |> assign(:board, this_board)}
        # {:noreply, update(socket, :board, fn _ -> Kanban.get_board!() end)}

      {:error, changeset} ->
        {:noreply, {:error, %{message: changeset.message}, socket}}
    end
  end

  # def handle_event("update_stage", %{"stage" => stage_attrs}, socket) do
  #   stage = Kanban.get_stage!(stage_attrs["id"])
  #
  #   case Kanban.update_stage(stage, stage_attrs) do
  #     {:ok, _updated_stage} ->
  #       this_board = socket.assigns.board
  #       {:noreply, update(socket, :board, fn _ -> Kanban.get_board!() end)}
  #
  #     {:error, changeset} ->
  #       {:noreply, {:error, %{message: changeset.message}, socket}}
  #   end
  # end

  def handle_info({Monitoring, [:comment, :posted], _}, socket) do
    card_id = socket.assigns.card_with_comments.id
    {:noreply, socket
              |> assign(card_with_comments: Kanban.get_card_for_comment!(card_id))
              |> push_event("updateScroll", %{})}
  end

  def handle_info({Monitoring, [:task, :updated], _}, socket) do
    board_id = socket.assigns.board.id
    {:noreply, assign(socket, board: Kanban.get_board!(board_id))}
  end

  def handle_info({Monitoring, [:task, :created], _}, socket) do
    board_id = socket.assigns.board.id
    {:noreply, assign(socket, board: Kanban.get_board!(board_id))}
  end

  def handle_info({Kanban, [_, :updated], _}, socket) do
    proj_id = socket.assigns.pro_id
    project = Monitoring.get_project!(proj_id)
    {:noreply, assign(socket, :board, Kanban.get_board!(project.board_id))}
  end

  def handle_info({Kanban, [_, :created], _}, socket) do
    proj_id = socket.assigns.pro_id
    project = Monitoring.get_project!(proj_id)
    {:noreply, assign(socket, :board, Kanban.get_board!(project.board_id))}
  end

  def handle_event("show_task_modal", %{}, socket), do: {:noreply, socket |> assign(show_task_modal: true)}

  def handle_event("show_comments_modal", %{"id" => id}, socket) do
    # IO.puts id
    card = Kanban.get_card_for_comment!(id)
    {:noreply, socket |> assign(show_comments_modal: true, card_with_comments: card)
                      |> push_event("updateScroll", %{})}
  end

  def handle_event("scroll-bot", %{}, socket) do
    {:noreply, socket |> push_event("updateScroll", %{})}
  end

  def handle_info({CommentsModalLive, :button_clicked, %{action: "cancel-comments"}},socket) do
    {:noreply, assign(socket, show_comments_modal: false)}
  end

  def handle_event("show_plus_modal", %{"id" => id}, socket) do
    card = Kanban.get_card_from_modal!(id)
    {:noreply, socket |> assign(show_plus_modal: true, card: card)}
  end

  def handle_event("show_modif_modal", %{"id" => id}, socket) do
    card = Kanban.get_card_from_modal!(id)
    {:noreply, socket |> assign(show_modif_modal: true, card: card)}
  end

  def handle_info({TaskModalLive, :button_clicked, %{action: "cancel"}},socket) do
    task_changeset = Monitoring.change_task(%Task{})
    {:noreply, assign(socket, show_task_modal: false, task_changeset: task_changeset )}
  end

  def handle_info({PlusModalLive, :button_clicked, %{action: "cancel-plus"}},socket) do
    # task_changeset = Monitoring.change_task(%Task{})
    {:noreply, assign(socket, show_plus_modal: false)}
  end

  def handle_info({ModifModalLive, :button_clicked, %{action: "cancel-modif"}},socket) do
    # task_changeset = Monitoring.change_task(%Task{})
    modif_changeset = Monitoring.change_task(%Task{})
    {:noreply, assign(socket, show_modif_modal: false, modif_changeset: modif_changeset)}
  end

  def handle_event("save", %{"task" => params}, socket) do
    # IO.inspect params
    case Monitoring.create_task_with_card(params) do
      {:ok, task} ->
        this_board = socket.assigns.board
        [head | _] = this_board.stages
        Kanban.create_card(%{name: task.title, stage_id: head.id ,task_id: task.id})
        {:noreply, socket
        |> put_flash(:info, "La tâche #{Monitoring.get_task!(task.id).title} a bien été créee")
        |> assign(show_task_modal: false)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket,task_changeset: changeset)}
    end
  end

  def handle_event("update_task", %{"task" => params}, socket) do
    #progression to int
    IO.inspect params
    int_progression = params["progression"] |> Float.parse |> elem(0) |> trunc
    attrs = %{params | "progression" => int_progression}
          #UPDATING
    task = Monitoring.get_task!(params["task_id"])
    # IO.inspect params
    # IO.inspect task
    # IO.inspect Monitoring.update_task(task, params)
    case Monitoring.update_task(task, attrs) do
      {:ok, task} ->
        # IO.inspect task
        # IO.inspect attrs
        {:ok, task} |> Monitoring.broadcast_updated_task
        {:noreply, socket |> put_flash(:info, "Tâche #{task.title} mise à jour") |> assign(show_modif_modal: false)}

      {:error, %Ecto.Changeset{} = changeset} ->
        # IO.inspect changeset
        # IO.inspect changeset.errors
        {:noreply, socket |> assign(modif_changeset: changeset)}
    end

  end

  def render(assigns) do
   ProjectView.render("board.html", assigns)
  end
end
