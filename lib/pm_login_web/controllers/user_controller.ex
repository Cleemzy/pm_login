defmodule PmLoginWeb.UserController do
  use PmLoginWeb, :controller

  alias PmLogin.Login
  alias PmLogin.Login.User
  alias PmLogin.Login.Right
  alias PmLogin.Login.Auth

  def index(conn, _params) do
    # users = Login.list_users()
    auths = Login.list_all_auth
    render(conn, "index.html", users: auths)
  end

  def new(conn, _params) do
    changeset = Login.change_user(%User{})
    render(conn, "new.html", changeset: changeset, layout: {PmLoginWeb.LayoutView, "register_layout.html"})
  end

  def create(conn, %{"user" => user_params}) do
    case Login.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, layout: {PmLoginWeb.LayoutView, "register_layout.html"})
    end
  end

  def show(conn, %{"id" => id}) do
    # user = Login.get_user!(id)
    user = Login.get_auth!(id)
    render(conn, "show.html", user: user)
  end

  def edit_profile(conn, %{"id" => id}) do
    user = Login.get_user!(id)
    changeset = Login.change_user(user)
    render(conn, "edit_profile.html", user: user, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    user = Login.get_user!(id)
    changeset = Login.change_user(user)
    rights = Login.list_rights
    str_rights = Enum.map(rights, fn %Right{} = r -> {String.to_atom(r.title), r.id}  end)
    render(conn, "edit.html", user: user, changeset: changeset, rights: rights, str_rights: str_rights)
  end

  def update_profile(conn, %{"id" => id, "user" => user_params}) do
    user = Login.get_user!(id)
    upload = user_params["photo"]

    case Login.update_profile(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Profile mise à jour.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_profile.html", user: user, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Login.get_user!(id)

    case Login.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Profile mise à jour.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Login.get_user!(id)
    {:ok, _user} = Login.delete_user(user)

    conn
    |> put_flash(:info, "#{user.username} éjecté(e).")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
