defmodule PmLoginWeb.ProjectController do
  use PmLoginWeb, :controller

  alias PmLogin.Services
  alias PmLogin.Monitoring
  alias PmLogin.Monitoring.Project
  alias PmLogin.Services.ActiveClient
  alias Phoenix.LiveView



  def board(conn, %{"id" => id}) do
    LiveView.Controller.live_render(conn, PmLoginWeb.Project.BoardLive, session: %{"curr_user_id" => get_session(conn, :curr_user_id), "pro_id" => id}, router: PmLoginWeb.Router)
  end

  def index(conn, _params) do
    projects = Monitoring.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, _params) do
    changeset = Monitoring.change_project(%Project{})
    ac_list = Services.list_active_clients
    ac_ids = Enum.map(ac_list, fn(%ActiveClient{} = ac) -> {ac.user.username, ac.id} end )
    render(conn, "new.html", changeset: changeset, ac_ids: ac_ids)
  end

  def create(conn, %{"project" => project_params}) do
    case Monitoring.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        ac_list = Services.list_active_clients
        ac_ids = Enum.map(ac_list, fn(%ActiveClient{} = ac) -> {ac.user.username, ac.id} end )
        render(conn, "new.html", changeset: changeset, ac_ids: ac_ids)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Monitoring.get_project!(id)
    render(conn, "show.html", project: project)
  end

  def edit(conn, %{"id" => id}) do
    project = Monitoring.get_project!(id)
    changeset = Monitoring.change_project(project)
    render(conn, "edit.html", project: project, changeset: changeset)
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
