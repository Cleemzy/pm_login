defmodule PmLoginWeb.ProjectController do
  use PmLoginWeb, :controller

  alias PmLogin.Services
  alias PmLogin.Monitoring
  alias PmLogin.Monitoring.Project
  alias PmLogin.Services.ActiveClient
  alias Phoenix.LiveView
  alias PmLogin.Login

  def board(conn, %{"id" => id}) do

    if Login.is_connected?(conn) do
      cond do
        Login.is_admin?(conn) ->
          LiveView.Controller.live_render(conn, PmLoginWeb.Project.BoardLive, session: %{"curr_user_id" => get_session(conn, :curr_user_id), "pro_id" => id}, router: PmLoginWeb.Router)

        true ->
          conn
            |> Login.not_admin_redirection
      end
    else
      conn
      |> Login.not_connected_redirection
    end

  end

  def index(conn, _params) do

    if Login.is_connected?(conn) do
      cond do
        Login.is_admin?(conn) ->
          projects = Monitoring.list_projects()
          render(conn, "index.html", projects: projects, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})

        true ->
          conn
            |> Login.not_admin_redirection
      end
    else
      conn
      |> Login.not_connected_redirection
    end

  end

  def new(conn, _params) do
    
    if Login.is_connected?(conn) do
      cond do
        Login.is_admin?(conn) ->
          changeset = Monitoring.change_project(%Project{})
          ac_list = Services.list_active_clients
          ac_ids = Enum.map(ac_list, fn(%ActiveClient{} = ac) -> {ac.user.username, ac.id} end )
          render(conn, "new.html", changeset: changeset, ac_ids: ac_ids)

        true ->
          conn
            |> Login.not_admin_redirection
      end
    else
      conn
      |> Login.not_connected_redirection
    end

end

  def create(conn, %{"project" => project_params}) do
    case Monitoring.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Projet #{Monitoring.get_project!(project.id).title} crée avec succès")
        |> redirect(to: Routes.project_path(conn, :board, project))


      {:error, %Ecto.Changeset{} = changeset} ->
        ac_list = Services.list_active_clients
        ac_ids = Enum.map(ac_list, fn(%ActiveClient{} = ac) -> {ac.user.username, ac.id} end )
        render(conn, "new.html", changeset: changeset, ac_ids: ac_ids)
    end
  end

  def show(conn, %{"id" => id}) do

    if Login.is_connected?(conn) do
      cond do
        Login.is_admin?(conn) ->
          project = Monitoring.get_project!(id)
          render(conn, "show.html", project: project, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})

        true ->
          conn
            |> Login.not_admin_redirection
      end
    else
      conn
      |> Login.not_connected_redirection
    end

  end

  def edit(conn, %{"id" => id}) do
    if Login.is_connected?(conn) do
      cond do
        Login.is_admin?(conn) ->
          project = Monitoring.get_project!(id)
          changeset = Monitoring.change_project(project)

          ac_list = Services.list_active_clients
          ac_ids = Enum.map(ac_list, fn(%ActiveClient{} = ac) -> {ac.user.username, ac.id} end )

          render(conn, "edit.html", project: project, changeset: changeset, ac_ids: ac_ids, layout: {PmLoginWeb.LayoutView, "admin_layout.html"})

        true ->
          conn
            |> Login.not_admin_redirection
      end
    else
      conn
      |> Login.not_connected_redirection
    end

  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Monitoring.get_project!(id)

    case Monitoring.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Monitoring.get_project!(id)
    {:ok, _project} = Monitoring.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :index))
  end
end
