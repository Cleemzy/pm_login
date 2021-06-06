defmodule PmLoginWeb.Services.MyRequestsLive do
  use Phoenix.LiveView
  alias PmLogin.Services
  alias PmLoginWeb.LiveComponent.ModalLive
  alias PmLogin.Services
  alias PmLogin.Services.ClientsRequest

  def mount(_params, %{"curr_user_id"=>curr_user_id}, socket) do
    Services.subscribe()
    Services.subscribe_to_request_topic()
    {:ok,
       socket
       |> assign(display_form: false,changeset:  Services.change_clients_request(%ClientsRequest{}),show_modal: false, service_id: nil,curr_user_id: curr_user_id,show_notif: false, notifs: Services.list_my_notifications_with_limit(curr_user_id, 4),
       requests: Services.list_my_requests(curr_user_id))
       |> allow_upload(:file, accept: ~w(.png .jpeg .jpg .zip), max_entries: 2),
       layout: {PmLoginWeb.LayoutView, "active_client_layout_live.html"}
       }
  end

  def handle_event("cancel-request", %{"key" => key}, socket) do
    case key do
      "Escape" ->
        {:noreply, socket |> assign(display_form: false)}
        _ ->
        {:noreply, socket}
    end
  end

  def handle_event("form-on", _params, socket) do
    {:noreply, socket |> assign(display_form: true)}
  end

  def handle_event("form-off", _params, socket) do
    {:noreply, socket |> assign(display_form: false)}
  end

  def handle_event("change-request", params, socket) do
    IO.inspect params
    {:noreply, socket}
  end

  def handle_event("send-request", %{"clients_request" => params}, socket) do

    case Services.create_clients_request(params) do
      {:ok, result} ->
          {:ok, result} |> Services.broadcast_request
          {:noreply, socket |> assign(changeset:  Services.change_clients_request(%ClientsRequest{})) |> put_flash(:info, "Requête envoyée")}

      {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, socket |> assign(changeset: changeset)}

    end

  end

  def handle_info({"request_topic", [:request, :sent], _}, socket) do
    {:noreply, socket |> assign(requests: Services.list_my_requests(socket.assigns.curr_user_id))}
  end

  def handle_info({"request_topic", [:request, :updated], _}, socket) do
    {:noreply, socket |> assign(requests: Services.list_my_requests(socket.assigns.curr_user_id))}
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

  def handle_info({Services, [:notifs, :sent], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    length = socket.assigns.notifs |> length
    {:noreply, socket |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, length))}
  end

  def render(assigns) do
   PmLoginWeb.ClientsRequestView.render("my_requests.html", assigns)
  end



end
