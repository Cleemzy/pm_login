defmodule PmLoginWeb.User.ListLive do
  use Phoenix.LiveView
  alias PmLogin.Login
  alias PmLoginWeb.UserView
  alias PmLoginWeb.UserController

  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    Login.subscribe()
   {:ok, fetch(socket)}
  end

  def handle_info({Login, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("arch", %{"id" => id}, socket) do
    user = Login.get_user!(id)
    Login.archive_user(user)
    # Log.delete_user(user)
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, users: Login.list_all_auth(),layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
  end

  def render(assigns) do
   UserView.render("index.html", assigns)
  end

end
