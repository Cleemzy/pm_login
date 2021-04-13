defmodule PmLoginWeb.CompanyController do
  use PmLoginWeb, :controller

  alias PmLogin.Services
  alias PmLogin.Services.Company

  def index(conn, _params) do
    companies = Services.list_companies()
    render(conn, "index.html", companies: companies, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
  end

  def new(conn, _params) do
    changeset = Services.change_company(%Company{})
    render(conn, "new.html", changeset: changeset, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
  end

  def create(conn, %{"company" => company_params}) do
    case Services.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
    end
  end

  def show(conn, %{"id" => id}) do
    company = Services.get_company!(id)
    render(conn, "show.html", company: company, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
  end

  def edit(conn, %{"id" => id}) do
    company = Services.get_company!(id)
    changeset = Services.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Services.get_company!(id)

    case Services.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Services.get_company!(id)
    {:ok, _company} = Services.delete_company(company)

    conn
    |> put_flash(:info, "Société enregistrée")
    |> redirect(to: Routes.company_path(conn, :index))
  end
end
