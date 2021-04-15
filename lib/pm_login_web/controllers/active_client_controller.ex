defmodule PmLoginWeb.ActiveClientController do
  use PmLoginWeb, :controller

  alias PmLogin.Services
  alias PmLogin.Services.ActiveClient

  def index(conn, _params) do
    active_clients = Services.list_active_clients()
    render(conn, "index.html", active_clients: active_clients)
  end

  def new(conn, _params) do
    changeset = Services.change_active_client(%ActiveClient{})
    render(conn, "new.html", changeset: changeset)
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
