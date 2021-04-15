defmodule PmLoginWeb.User.ListLive do
  use Phoenix.LiveView
  alias PmLogin.Login
  alias PmLoginWeb.UserView
  alias PmLoginWeb.UserController
  alias PmLoginWeb.LiveComponent.ModalLive

  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    Login.subscribe()
   {:ok,
      socket
      |> assign(curr_user_id: curr_user_id)
      |> fetch
      }
  end

  def handle_info({Login, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Login, [:right | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("switch", %{"id" => id}, socket) do  
    {:noreply, assign(socket, users: Login.filter_auth(id))}
  end

  def handle_event("arch", %{"id" => id}, socket) do
    user = Login.get_user!(id)
    Login.archive_user(user)
    # Log.delete_user(user)

    {:noreply, put_flash(socket, :info, "L'utilisateur #{user.username} a bien été archivé")}
  end

  defp fetch(socket) do
    assign(socket, users: Login.list_asc_auth(), rights: Login.list_rights(),show_modal: false, arch_id: nil,layout: {PmLoginWeb.LayoutView, "admin_layout_live.html"})
  end

  def render(assigns) do
   UserView.render("index.html", assigns)
  end

  #modal_component

  def handle_info(
      {ModalLive, :button_clicked, %{action: "cancel-arch"}},
      socket
    ) do
  {:noreply, assign(socket, show_modal: false)}
  end

  def handle_info(
      {ModalLive, :button_clicked, %{action: "arch", param: arch_id}},
      socket
    ) do
      user = Login.get_user!(arch_id)
      Login.archive_user(user)
      # PmLoginWeb.UserController.archive(socket, user.id)
  {:noreply,
    socket
    |> put_flash(:info, "L'utilisateur a bien été archivé!")
    |> assign(show_modal: false)
      }
  end

  def handle_event("go-arch", %{"id" => id}, socket) do
    # Phoenix.LiveView.get_connect_info(socket)
    # put_session(socket, del_id: id)
    {:noreply, assign(socket, show_modal: true, arch_id: id)}
  end


end
