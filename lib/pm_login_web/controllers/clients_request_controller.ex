defmodule PmLoginWeb.ClientsRequestController do
  use PmLoginWeb, :controller

  # alias PmLogin.Services
  # alias PmLogin.Services.ClientsRequest

  # def index(conn, _params) do
  #   clients_requests = Services.list_clients_requests()
  #   render(conn, "index.html", clients_requests: clients_requests)
  # end

  # def new(conn, _params) do
  #   changeset = Services.change_clients_request(%ClientsRequest{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"clients_request" => clients_request_params}) do
  #   case Services.create_clients_request(clients_request_params) do
  #     {:ok, clients_request} ->
  #       conn
  #       |> put_flash(:info, "Clients request created successfully.")
  #       |> redirect(to: Routes.clients_request_path(conn, :show, clients_request))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   clients_request = Services.get_clients_request!(id)
  #   render(conn, "show.html", clients_request: clients_request)
  # end

  # def edit(conn, %{"id" => id}) do
  #   clients_request = Services.get_clients_request!(id)
  #   changeset = Services.change_clients_request(clients_request)
  #   render(conn, "edit.html", clients_request: clients_request, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "clients_request" => clients_request_params}) do
  #   clients_request = Services.get_clients_request!(id)
  #
  #   case Services.update_clients_request(clients_request, clients_request_params) do
  #     {:ok, clients_request} ->
  #       conn
  #       |> put_flash(:info, "Clients request updated successfully.")
  #       |> redirect(to: Routes.clients_request_path(conn, :show, clients_request))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", clients_request: clients_request, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   clients_request = Services.get_clients_request!(id)
  #   {:ok, _clients_request} = Services.delete_clients_request(clients_request)
  #
  #   conn
  #   |> put_flash(:info, "Clients request deleted successfully.")
  #   |> redirect(to: Routes.clients_request_path(conn, :index))
  # end
end
