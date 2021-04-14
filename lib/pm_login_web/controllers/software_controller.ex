defmodule PmLoginWeb.SoftwareController do
  use PmLoginWeb, :controller

  alias PmLogin.Services
  alias PmLogin.Services.Software

  def index(conn, _params) do
    softwares = Services.list_softwares()
    render(conn, "index.html", softwares: softwares)
  end

  def new(conn, _params) do
    changeset = Services.change_software(%Software{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"software" => software_params}) do
    case Services.create_software(software_params) do
      {:ok, software} ->
        conn
        |> put_flash(:info, "Software created successfully.")
        |> redirect(to: Routes.software_path(conn, :show, software))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    software = Services.get_software!(id)
    render(conn, "show.html", software: software)
  end

  def edit(conn, %{"id" => id}) do
    software = Services.get_software!(id)
    changeset = Services.change_software(software)
    render(conn, "edit.html", software: software, changeset: changeset)
  end

  def update(conn, %{"id" => id, "software" => software_params}) do
    software = Services.get_software!(id)

    case Services.update_software(software, software_params) do
      {:ok, software} ->
        conn
        |> put_flash(:info, "Software updated successfully.")
        |> redirect(to: Routes.software_path(conn, :show, software))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", software: software, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    software = Services.get_software!(id)
    {:ok, _software} = Services.delete_software(software)

    conn
    |> put_flash(:info, "Software deleted successfully.")
    |> redirect(to: Routes.software_path(conn, :index))
  end
end
