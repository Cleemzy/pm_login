defmodule PmLoginWeb.Project.BoardLive do
  use Phoenix.LiveView

  alias PmLoginWeb.LiveComponent.TaskModalLive

  alias PmLoginWeb.ProjectView
  alias PmLogin.Monitoring
  alias PmLogin.Kanban
  alias PmLogin.Monitoring.Task

  def mount(_params,%{"curr_user_id" => curr_user_id ,"pro_id" => pro_id}, socket) do
    if connected?(socket), do: Kanban.subscribe()
    project = Monitoring.get_project!(pro_id)
    task_changeset = Monitoring.change_task(%Task{})
    {:ok, assign(socket,curr_user_id: curr_user_id, pro_id: pro_id,board: Kanban.get_board!(project.board_id), show_task_modal: false, task_changeset: task_changeset,layout: {PmLoginWeb.LayoutView, "board_layout_live.html"})}
  end

  def handle_event("update_card", %{"card" => card_attrs}, socket) do
    card = Kanban.get_card!(card_attrs["id"])
    # IO.inspect card_attrs
    # IO.inspect updated_stage
    case Kanban.update_card(card, card_attrs) do
      {:ok, _updated_card} ->
        updated_task = card.task_id |> Monitoring.get_task!
        updated_stage = card_attrs["stage_id"] |> Kanban.get_stage!
        task_attrs = %{"status_id" => updated_stage.status_id}
        Monitoring.update_task(updated_task, task_attrs)
        this_board = socket.assigns.board
        {:noreply, assign(socket, :board, this_board)}
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

  def handle_info({TaskModalLive, :button_clicked, %{action: "cancel"}},socket) do
    {:noreply, assign(socket, show_task_modal: false)}
  end

  def handle_event("save", %{"task" => params}, socket) do
    # IO.inspect params
    case Monitoring.create_task_with_card(params) do
      {:ok, task} ->
        this_board = socket.assigns.board
        [head | _] = this_board.stages
        Kanban.create_card(%{name: task.title, stage_id: head.id ,task_id: task.id})
        {:noreply, socket |> assign(show_task_modal: false)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket,task_changeset: changeset)}
    end
  end

  def render(assigns) do
   ProjectView.render("board.html", assigns)
  end
end
