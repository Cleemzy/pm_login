defmodule PmLoginWeb.AuthController do
  use PmLoginWeb, :controller
  alias PmLogin.Login
  alias PmLogin.Login.User

  defmodule Userss do
    defstruct [:username, :password]
  end

  # def check_by_username(user, list) do
  #
  #   for u <- list do
  #     if user.username === u.username do
  #       check = true
  #     end
  #   end
  #
  # end



  # defp check_if_user(%Userss{} = u, list) do
  #   usernames = Enum.map(list, fn %Userss{} = user -> user.username end )
  #   Enum.member?(usernames, u.username)
  # end

  def test_auth(conn, %{"user" => user}) do
    render(conn, "test.html", user: user)
  end

  def auth(conn, %{"user" => user_params}) do
    case Login.log_user(user_params) do
      {:ok, user} ->
        users_list = Login.list_users
        us = Enum.find(users_list, fn %User{} = u -> u.username === user.username end )
        conn
        |> put_flash(:info, "Bienvenue, "<>user.username<>" !")
        |> put_session(:curr_user_id, us.id)
        |> redirect(to: Routes.user_path(conn, :index))
        # conn
        # |> put_flash(:info, "User created successfully.")
        # |> redirect(to: "/test_auth")

        # |> test_auth(%{""})
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset, layout: {PmLoginWeb.LayoutView, "login_layout.html"})
    end


    # render(conn, "test.html", user: user_params)


    # encrypted = :crypto.hash(:sha256, password)
    # user_list = Login.list_users
    #
    #
    # encrypted = Bcrypt.hash_pwd_salt(password)
    # user = %Userss{username: username, password: encrypted}
    #
    # user1 = %Userss{username: "Paul", password: "Mazoto"}
    # user2 = %Userss{username: "Rojo", password: "Raben"}
    # users = [user1]
    # users = users ++ [user2]
    # u1_encrypted = Bcrypt.hash_pwd_salt(user1.password)



    # check = Enum.member?([users],user)
    # IO.puts check
    # conn
    # |> put_session(:curr_user_uname, user.username)
    # |> render("test.html", _csrf_token: _csrf_token, user: user, users: users, check: check_if_user(user, users), good: Bcrypt.verify_pass(password, u1_encrypted), user_list: user_list)
    # redirect(conn, to: "/redirect_test")
  end


  def sign_out(conn, _params) do
    conn
    |> delete_session(:curr_user_id)
    # |> configure_session(drop: :true)
    |> put_flash(:info, "Vous vous êtes déconnecté.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
