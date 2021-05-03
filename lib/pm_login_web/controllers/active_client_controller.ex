defmodule PmLoginWeb.ActiveClientController do
  use PmLoginWeb, :controller

  alias PmLogin.Services
  alias PmLogin.Services.ActiveClient
  alias PmLogin.Login

  alias Phoenix.LiveView


  def index(conn, _params) do
    active_clients = Services.list_active_clients()
    render(conn, "index.html", active_clients: active_clients, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
  end

  def new(conn, _params) do
    # changeset = Services.change_active_client(%ActiveClient{})
    # inactive_clients = Login.list_non_active_clients
    # render(conn, "new.html", changeset: changeset, inactives: inactive_clients)
    LiveView.Controller.live_render(conn, PmLogin.ActiveClient.ActiveClientLive, session: %{"curr_user_id" => get_session(conn, :curr_user_id)}, router: PmLoginWeb.Router)

  end

  def create(conn, %{"active_client" => active_client_params}) do
    case Services.create_active_client(active_client_params) do
      {:ok, active_client} ->
        conn
        |> put_flash(:info, "Active client created successfully.")
        |> redirect(to: Routes.active_client_path(conn, :show, active_client))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    active_client = Services.get_active_client!(id)
    render(conn, "show.html", active_client: active_client)
  end

  def edit(conn, %{"id" => id}) do
    active_client = Services.get_active_client!(id)
    changeset = Services.change_active_client(active_client)
    render(conn, "edit.html", active_client: active_client, changeset: changeset)
  end

  def update(conn, %{"id" => id, "active_client" => active_client_params}) do
    active_client = Services.get_active_client!(id)

    case Services.update_active_client(active_client, active_client_params) do
      {:ok, active_client} ->
        conn
        |> put_flash(:info, "Active client updated successfully.")
        |> redirect(to: Routes.active_client_path(conn, :show, active_client))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", active_client: active_client, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    active_client = Services.get_active_client!(id)
    {:ok, _active_client} = Services.delete_active_client(active_client)

    conn
    |> put_flash(:info, "Active client deleted successfully.")
    |> redirect(to: Routes.active_client_path(conn, :index))
  end
end
