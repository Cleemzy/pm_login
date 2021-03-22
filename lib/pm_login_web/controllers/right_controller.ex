defmodule PmLoginWeb.RightController do
  use PmLoginWeb, :controller

  alias PmLogin.Login
  alias PmLogin.Login.Right

  def index(conn, _params) do
    rights = Login.list_rights()
    render(conn, "index.html", rights: rights)
  end

  def new(conn, _params) do
    changeset = Login.change_right(%Right{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"right" => right_params}) do
    case Login.create_right(right_params) do
      {:ok, right} ->
        conn
        |> put_flash(:info, "Right created successfully.")
        |> redirect(to: Routes.right_path(conn, :show, right))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    right = Login.get_right!(id)
    render(conn, "show.html", right: right)
  end

  def edit(conn, %{"id" => id}) do
    right = Login.get_right!(id)
    changeset = Login.change_right(right)
    render(conn, "edit.html", right: right, changeset: changeset)
  end

  def update(conn, %{"id" => id, "right" => right_params}) do
    right = Login.get_right!(id)

    case Login.update_right(right, right_params) do
      {:ok, right} ->
        conn
        |> put_flash(:info, "Right updated successfully.")
        |> redirect(to: Routes.right_path(conn, :show, right))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", right: right, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    right = Login.get_right!(id)
    {:ok, _right} = Login.delete_right(right)

    conn
    |> put_flash(:info, "Right deleted successfully.")
    |> redirect(to: Routes.right_path(conn, :index))
  end
end
