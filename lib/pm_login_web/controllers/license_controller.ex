defmodule PmLoginWeb.LicenseController do
  use PmLoginWeb, :controller

  # alias PmLogin.Services
  # alias PmLogin.Services.License

  # def index(conn, _params) do
  #   licenses = Services.list_licenses()
  #   render(conn, "index.html", licenses: licenses)
  # end

  # def new(conn, _params) do
  #   changeset = Services.change_license(%License{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"license" => license_params}) do
  #   case Services.create_license(license_params) do
  #     {:ok, license} ->
  #       conn
  #       |> put_flash(:info, "License created successfully.")
  #       |> redirect(to: Routes.license_path(conn, :show, license))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   license = Services.get_license!(id)
  #   render(conn, "show.html", license: license)
  # end

  # def edit(conn, %{"id" => id}) do
  #   license = Services.get_license!(id)
  #   changeset = Services.change_license(license)
  #   render(conn, "edit.html", license: license, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "license" => license_params}) do
  #   license = Services.get_license!(id)
  #
  #   case Services.update_license(license, license_params) do
  #     {:ok, license} ->
  #       conn
  #       |> put_flash(:info, "License updated successfully.")
  #       |> redirect(to: Routes.license_path(conn, :show, license))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", license: license, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   license = Services.get_license!(id)
  #   {:ok, _license} = Services.delete_license(license)
  #
  #   conn
  #   |> put_flash(:info, "License deleted successfully.")
  #   |> redirect(to: Routes.license_path(conn, :index))
  # end

end
