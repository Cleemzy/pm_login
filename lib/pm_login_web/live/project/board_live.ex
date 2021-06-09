defmodule PmLoginWeb.Project.BoardLive do
  use Phoenix.LiveView

  alias PmLoginWeb.LiveComponent.{TaskModalLive,PlusModalLive,ModifModalLive,CommentsModalLive,SecondaryModalLive}

  alias PmLoginWeb.ProjectView
  alias PmLogin.Monitoring
  alias PmLogin.Kanban
  alias PmLogin.Monitoring.{Task, Priority}
  alias PmLogin.Login
  alias PmLogin.Login.User
  alias PmLogin.Services
  alias PmLogin.Monitoring.Comment

  def mount(_params,%{"curr_user_id" => curr_user_id ,"pro_id" => pro_id}, socket) do
    if connected?(socket), do: Kanban.subscribe()
    Monitoring.subscribe()
    Monitoring.hidden_subscribe()
    Services.subscribe()

    layout = case Login.get_user!(curr_user_id).right_id do
      1 -> {PmLoginWeb.LayoutView, "board_layout_live.html"}
      2 -> {PmLoginWeb.LayoutView, "attributor_board_live.html"}
      3 -> {PmLoginWeb.LayoutView, "contributor_board_live.html"}
      _ -> {}
    end



    project = Monitoring.get_project!(pro_id)

    task_changeset = Monitoring.change_task(%Task{})
    modif_changeset = Monitoring.change_task(%Task{})

    priorities = Monitoring.list_priorities
    list_priorities = Enum.map(priorities, fn (%Priority{} = p)  -> {p.title, p.id} end)

    contributors = Login.list_contributors
    list_contributors = Enum.map(contributors, fn (%User{} = p)  -> {p.username, p.id} end)

    secondary_changeset = Monitoring.change_task(%Task{})
    my_primary_tasks = Monitoring.list_primary_tasks(curr_user_id, pro_id)
    list_primaries = my_primary_tasks |> Enum.map(fn (%Task{} = p) -> {p.title, p.id} end)

    {:ok, socket |> assign(is_attributor: Monitoring.is_attributor?(curr_user_id),is_admin: Monitoring.is_admin?(curr_user_id), show_plus_modal: false,curr_user_id: curr_user_id, pro_id: pro_id, show_secondary: false,
                    contributors: list_contributors, priorities: list_priorities, board: Kanban.get_board!(project.board_id), show_task_modal: false, show_modif_modal: false,
                    primaries: list_primaries, is_contributor: Monitoring.is_contributor?(curr_user_id),task_changeset: task_changeset, modif_changeset: modif_changeset, show_comments_modal: false,
                    show_notif: false, notifs: Services.list_my_notifications_with_limit(curr_user_id, 4), secondary_changeset: secondary_changeset, comment_changeset: Monitoring.change_comment(%Comment{})), layout: layout
                  }
  end

  def handle_event("hide-card", %{"id" => id}, socket) do
    task = Monitoring.get_task!(id)
    Monitoring.hide_task(task)

    {:noreply, socket}
  end

  def handle_event("show_hidden_tasks", _params, socket) do
    pro_id = socket.assigns.board.project.id
    Monitoring.show_hidden_tasks(pro_id)
    {:noreply, socket}
  end

  def handle_info({"hidden_subscription", [:task, :hidden], _}, socket) do
    board_id = socket.assigns.board.id
    {:noreply, socket |> assign(board: Kanban.get_board!(board_id))}
  end

  def handle_info({"hidden_subscription", [:tasks, :shown], _}, socket) do
    board_id = socket.assigns.board.id
    {:noreply, socket |> assign(board: Kanban.get_board!(board_id))}
  end

  def handle_event("switch-notif", %{}, socket) do
    notifs_length = socket.assigns.notifs |> length
    curr_user_id = socket.assigns.curr_user_id
    switch = if socket.assigns.show_notif do
              ids = socket.assigns.notifs
                    |> Enum.filter(fn(x) -> !(x.seen) end)
                    |> Enum.map(fn(x) -> x.id  end)
              Services.put_seen_some_notifs(ids)
                false
              else
                true
             end
    {:noreply, socket |> assign(show_notif: switch, notifs: Services.list_my_notifications_with_limit(curr_user_id, notifs_length))}
  end

  def handle_event("load-notifs", %{}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    notifs_length = socket.assigns.notifs |> length
    {:noreply, socket |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, notifs_length+4))}
  end

  def handle_event("cancel-notif", %{}, socket) do
    cancel = if socket.assigns.show_notif, do: false
    {:noreply, socket |> assign(show_notif: cancel)}
  end

  def handle_event("key_cancel", %{"key" => key}, socket) do

    show_task_modal = socket.assigns.show_task_modal
    show_secondary = socket.assigns.show_secondary
    show_plus_modal = socket.assigns.show_plus_modal
    show_modif_modal = socket.assigns.show_modif_modal
    show_comments_modal = socket.assigns.show_comments_modal

    s_task_modal = if (key == "Escape" and show_task_modal == true) ,do: false ,else: show_task_modal
    s_secondary = if (key == "Escape" and show_secondary == true) ,do: false ,else: show_secondary
    s_plus_modal = if (key == "Escape" and show_plus_modal == true) ,do: false ,else: show_plus_modal
    s_modif_modal = if (key == "Escape" and show_modif_modal == true) ,do: false ,else: show_modif_modal
    s_comments_modal = if (key == "Escape" and show_comments_modal == true) ,do: false ,else: show_comments_modal

    {:noreply, socket
               |> assign(show_task_modal: s_task_modal,
                          show_secondary: s_secondary,
                          show_plus_modal: s_plus_modal,
                          show_modif_modal: s_modif_modal,
                          show_comments_modal: s_comments_modal)}
  end

  def handle_event("show_alert_test", _params, socket) do
    {:noreply, socket |> put_flash(:info, "oiii")}
  end

  def handle_event("color_alert_test", _params, socket) do
    {:noreply, socket |> put_flash(:info, "iooo") |> push_event("AnimateAlert", %{})}
  end

  def handle_event("show-secondary", %{}, socket) do
    {:noreply, socket |> assign(show_secondary: true)}
  end

  def handle_info({SecondaryModalLive, :button_clicked, %{action: "cancel-secondary"}},socket) do
    {:noreply, assign(socket, show_secondary: false, secondary_changeset: Monitoring.change_task(%Task{}))}
  end

  def handle_event("send-comment", %{"comment" => params}, socket) do
    # IO.puts task_id
    # IO.puts poster_id
    # IO.puts content

    case Monitoring.post_comment(params) do
      {:ok, result} ->
        card_id = socket.assigns.card_with_comments.id
        nb_com = socket.assigns.com_nb
        {:ok, result} |> Monitoring.broadcast_com
        {:noreply, socket |> assign(comment_changeset:  Monitoring.change_comment(%Comment{}),card_with_comments: Kanban.get_card_for_comment_limit!(card_id, nb_com), com_nb: nb_com) |>push_event("updateScroll", %{})}

      {:error, %Ecto.Changeset{} = changeset} ->
        card_id = socket.assigns.card_with_comments.id
        nb_com = socket.assigns.com_nb
        {:noreply, socket |> assign(comment_changeset: changeset) |> push_event("updateScroll", %{})}

    end


  end

  def handle_event("update_card", %{"card" => card_attrs}, socket) do
    card = Kanban.get_card!(card_attrs["id"])
    # IO.inspect card_attrs
    # IO.inspect updated_stage
    # IO.puts "before"
    # IO.inspect card
    case Kanban.update_card(card, card_attrs) do
      {:ok, _updated_card} ->
        updated_task = card.task_id |> Monitoring.get_task!
        updated_stage = card_attrs["stage_id"] |> Kanban.get_stage!
        task_attrs = %{"status_id" => updated_stage.status_id}
        IO.inspect Monitoring.update_task_status(updated_task, task_attrs)
        {:ok, real_task} = Monitoring.update_task_status(updated_task, task_attrs)
        {:ok, real_task} |> Monitoring.broadcast_status_change
        # IO.inspect real_task
        # IO.inspect Monitoring.get_task!(real_task.id)
        this_board = socket.assigns.board

        IO.puts "after"
        IO.inspect card
        IO.inspect Kanban.get_stage!(card.stage_id)

        #ADDING CHILD TASK TO ACHIEVED STAGE
        if Monitoring.is_a_child?(real_task) and Kanban.get_stage!(card.stage_id).status_id != 5 and real_task.status_id == 5 do
          curr_user_id = socket.assigns.curr_user_id
          Monitoring.update_mother_task_progression(real_task, curr_user_id)
        end

        #REMOVING CHILD TASK FROM ACHIEVED STAGE
        if Monitoring.is_a_child?(real_task) and Kanban.get_stage!(card.stage_id).status_id == 5 and real_task.status_id != 5  do
          Monitoring.substract_mother_task_progression_when_removing_child_from_achieved(real_task)
        end

        #ADDING PRIMARY TASK TO ACHIEVED STAGE
        if Monitoring.is_task_primary?(real_task) and Kanban.get_stage!(card.stage_id).status_id != 5 and real_task.status_id == 5 do
          project = socket.assigns.board.project
          Monitoring.add_progression_to_project(project)
        end

        #ADDING MOTHER TASK TO ACHIEVED STAGE
        if Monitoring.is_task_mother?(real_task) and Kanban.get_stage!(card.stage_id).status_id != 5 and real_task.status_id == 5 do
          Monitoring.achieve_children_tasks(real_task, socket.assigns.curr_user_id)
        end

        #REMOVING PRIMARY TASK FROM ACHIEVED STAGE
        if Monitoring.is_task_primary?(real_task) and Kanban.get_stage!(card.stage_id).status_id == 5 and real_task.status_id != 5 do
          project = socket.assigns.board.project
          Monitoring.substract_progression_to_project(project)
        end

        #IF TASK IS UPTADET ON THE SAME STAGE
        post_socket = if Kanban.get_stage!(card.stage_id).status_id == real_task.status_id do

          socket
        else
          curr_user_id = socket.assigns.curr_user_id
          Services.send_notifs_to_admins_and_attributors(curr_user_id, "Tâche \"#{Monitoring.get_task_with_status!(real_task.id).title}\"
          du projet #{socket.assigns.board.project.title} mise dans \" #{Monitoring.get_task_with_status!(real_task.id).status.title} \" par #{Login.get_user!(curr_user_id).username}")

          socket |> put_flash(:info, "Tâche \"#{Monitoring.get_task_with_status!(real_task.id).title}\" mise dans \" #{Monitoring.get_task_with_status!(real_task.id).status.title} \" ")
        end

        {:noreply, post_socket |> assign(:board, this_board)}
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

  def handle_info({Services, [:notifs, :sent], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    length = socket.assigns.notifs |> length
    {:noreply, socket |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, length))}
  end

  def handle_info({Monitoring, [:comment, :posted], _}, socket) do
    card_id = socket.assigns.card_with_comments.id
    nb_com = socket.assigns.com_nb
    {:noreply, socket
              |> assign(card_with_comments: Kanban.get_card_for_comment_limit!(card_id, nb_com), com_nb: nb_com)
              |> push_event("updateScroll", %{})}
  end

  def handle_info({Monitoring, [:task, :updated], _}, socket) do
    board_id = socket.assigns.board.id

    #for secondary task modal select form
    curr_user_id = socket.assigns.curr_user_id
    my_primary_tasks = Monitoring.list_primary_tasks(curr_user_id, socket.assigns.board.project.id)
    list_primaries = my_primary_tasks |> Enum.map(fn (%Task{} = p) -> {p.title, p.id} end)

    {:noreply, assign(socket, board: Kanban.get_board!(board_id), primaries: list_primaries)}
  end

  def handle_info({Monitoring, [:status, :updated], _}, socket) do
    board_id = socket.assigns.board.id

    #for secondary task modal select form
    curr_user_id = socket.assigns.curr_user_id
    my_primary_tasks = Monitoring.list_primary_tasks(curr_user_id, socket.assigns.board.project.id)
    list_primaries = my_primary_tasks |> Enum.map(fn (%Task{} = p) -> {p.title, p.id} end)

    {:noreply, assign(socket, board: Kanban.get_board!(board_id), primaries: list_primaries)}
  end

  def handle_info({Monitoring, [:project, :updated], _}, socket) do
    board_id = socket.assigns.board.id
    {:noreply, assign(socket, board: Kanban.get_board!(board_id))}
  end

  def handle_info({Monitoring, [:mother, :updated], _}, socket) do
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
    # IO.puts "com modal showed"
    IO.puts id
    com_nb = 5
    card = Kanban.get_card_for_comment_limit!(id,com_nb)
    # card = ordered |> Enum.reverse
    {:noreply, socket |> assign(show_comments_modal: true, card_with_comments: card, com_nb: com_nb)
                      |> push_event("updateScroll", %{})}
  end

  def handle_event("load_comments", %{}, socket) do
    IO.puts "load"
    card_id = socket.assigns.card_with_comments.id
    nb_com = socket.assigns.com_nb + 5
    card = Kanban.get_card_for_comment_limit!(card_id,nb_com)
    {:noreply, socket |> assign(com_nb: nb_com, card_with_comments: card)}
  end

  def handle_event("scroll-bot", %{}, socket) do
    # IO.puts "niditra scroll"
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

  def handle_event("submit_secondary", %{"task" => params}, socket) do
    IO.puts "input"
    IO.inspect params

    parent_task = Monitoring.get_task!(params["parent_id"])
    parent_params = %{"attributor_id" => parent_task.attributor_id,
                    "priority_id" => parent_task.priority_id,
                    "deadline" => parent_task.deadline}
    IO.puts "parent params"
    IO.inspect parent_params

    IO.puts "output"
    op_params = params |> Map.merge(parent_params)
    IO.inspect op_params


    case Monitoring.create_secondary_task(op_params) do
      {:ok, task} ->
        Monitoring.substract_mother_task_progression_when_creating_child(task)
        this_board = socket.assigns.board
        [head | _] = this_board.stages
        Kanban.create_card(%{name: task.title, stage_id: head.id ,task_id: task.id})
        #NOTIFY ATTRIBUTOR THAT A SECONDARY TASK HAS BEEN CREATED
        Services.send_notif_to_one(task.contributor_id, task.attributor_id, "Une tâche fille de votre tâche primaire #{Monitoring.get_task!(task.parent_id).title} du nom de #{task.title} a été créee par #{Login.get_user!(task.contributor_id).username} dans le projet #{this_board.project.title}")
        {:noreply, socket
        |> put_flash(:info, "La tâche secondaire #{Monitoring.get_task!(task.id).title} a bien été créee")
        |> assign(show_secondary: false)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket,secondary_changeset: changeset)}

    end
  end

  def handle_event("save", %{"task" => params}, socket) do
    # IO.inspect params
    case Monitoring.create_task_with_card(params) do
      {:ok, task} ->
        this_board = socket.assigns.board

        this_project = socket.assigns.board.project
        Monitoring.substract_project_progression_when_creating_primary(this_project)

        [head | _] = this_board.stages
        Kanban.create_card(%{name: task.title, stage_id: head.id ,task_id: task.id})
        #SEND NEW TASK NOTIFICATION TO ADMINS AND ATTRIBUTORS
        curr_user_id = socket.assigns.curr_user_id
        Services.send_notifs_to_admins_and_attributors(curr_user_id,"Tâche nouvellement créee du nom de #{task.title} par #{Login.get_user!(curr_user_id).username} dans le projet #{this_project.title}.")
        {:noreply, socket
        |> put_flash(:info, "La tâche #{Monitoring.get_task!(task.id).title} a bien été créee")
        |> assign(show_task_modal: false)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket,task_changeset: changeset)}
    end
  end

  def handle_event("update_task", %{"task" => params}, socket) do
    #progression to int
    IO.puts "OIIIIIIIIII"
    # IO.inspect params
    int_progression = params["progression"] |> Float.parse |> elem(0) |> trunc
    attrs = %{params | "progression" => int_progression}
          #UPDATING
    task = Monitoring.get_task!(params["task_id"])
    # IO.inspect params
    # IO.inspect task
    # IO.inspect Monitoring.update_task(task, params)
    case Monitoring.update_task(task, attrs) do
      {:ok, updated_task} ->
        # IO.inspect task
        # IO.inspect attrs
        {:ok, updated_task} |> Monitoring.broadcast_updated_task

        # IO.inspect {:ok, task}
        # IO.inspect {:ok, updated_task}

        if (is_nil task.contributor_id) and not (is_nil updated_task.contributor_id) do
          Services.send_notif_to_one(updated_task.attributor_id, updated_task.contributor_id, "#{Login.get_user!(updated_task.attributor_id).username} vous a assigné à la tâche #{updated_task.title}.")
        end
        {:noreply, socket |> put_flash(:info, "Tâche #{updated_task.title} mise à jour") |> assign(show_modif_modal: false)}

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
