defmodule PmLogin.ActiveClient.ActiveClientLive do
  use Phoenix.LiveView

  alias PmLogin.Login
  alias PmLogin.Login.User
  alias PmLogin.Services
  alias PmLogin.Services.{Company, ActiveClient}
  alias PmLoginWeb.LiveComponent.ModalLive

  def mount(_params, %{}, socket) do
    Services.subscribe()
    {:ok, assign(socket,show_modal: false, params: nil,inactives: Login.list_non_active_clients,
                companies: Enum.map(Services.list_companies, fn %Company{} = c -> {c.name, c.id} end),
                layout: {PmLoginWeb.LayoutView, "admin_layout_live.html"})}
  end

  def handle_info(
      {ModalLive, :button_clicked, %{action: "confirm-activate", param: params}},
      socket
    ) do
      params |> Services.create_active_client
  {:noreply,
    socket
    |> put_flash(:info, "Le client #{PmLogin.Login.get_user!(params["user_id"]).username} a bien été rendu actif et affilié à #{PmLogin.Services.get_company!(params["company_id"]).name}!")
    |> assign(show_modal: false)
      }
  end

  def handle_info(
      {ModalLive, :button_clicked, %{action: "cancel-active", param: _}},
      socket
    ) do
  {:noreply,
    socket
    |> assign(show_modal: false)
      }
  end

  def handle_event("activate_c", %{"client_id" => client_id, "nil" => %{"company_id" => company_id}}, socket) do
    IO.puts client_id
    IO.puts company_id
    params = %{"user_id" => client_id, "company_id" => company_id}
    IO.inspect params
    # Services.create_active_client(%{"user_id" => client_id, "company_id" => company_id})
    {:noreply, assign(socket, params: params, show_modal: true)}
  end

  def handle_info({Services, [:active_client, :created], _}, socket) do
    {:noreply, assign(socket,  inactives: Login.list_non_active_clients)}
  end

  def render(assigns) do
    PmLoginWeb.ActiveClientView.render("new.html", assigns)
  end
end
