defmodule PmLoginWeb.Right.IndexLive do
  use Phoenix.LiveView
  alias PmLogin.Login
  alias PmLoginWeb.RightView
  alias PmLoginWeb.RightController
  alias PmLoginWeb.LiveComponent.ModalLive

  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    Login.subscribe()
   {:ok,
      socket
      |> assign(curr_user_id: curr_user_id)
      |> fetch
      }
  end

  def handle_info({Login, [:right | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, rights: Login.list_asc_rights(),show_modal: false, del_id: nil,layout: {PmLoginWeb.LayoutView, "admin_layout_live.html"})
  end


  def render(assigns) do
   RightView.render("index.html", assigns)
  end


  #modal_component

  def handle_info(
      {ModalLive, :button_clicked, %{action: "cancel-del"}},
      socket
    ) do
  {:noreply, assign(socket, show_modal: false)}
  end

  def handle_info(
      {ModalLive, :button_clicked, %{action: "delete", param: del_id}},
      socket
    ) do
      right = Login.get_right!(del_id)
      Login.delete_right(right)
  {:noreply,
    socket
    |> assign(show_modal: false)
      }
  end

  def handle_event("go-del", %{"id" => id}, socket) do
    {:noreply, assign(socket, show_modal: true, del_id: id)}
  end

end
