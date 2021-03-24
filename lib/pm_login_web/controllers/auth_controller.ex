defmodule PmLoginWeb.AuthController do
  use PmLoginWeb, :controller
  alias PmLogin.Login

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



  defp check_if_user(%Userss{} = u, list) do
    usernames = Enum.map(list, fn %Userss{} = user -> user.username end )
    Enum.member?(usernames, u.username)
  end

  def auth(conn, %{"_csrf_token" => _csrf_token, "username" => username, "password" => password}) do
    # encrypted = :crypto.hash(:sha256, password)
    user_list = Login.list_users


    encrypted = Bcrypt.hash_pwd_salt(password)
    user = %Userss{username: username, password: encrypted}

    user1 = %Userss{username: "Paul", password: "Mazoto"}
    user2 = %Userss{username: "Rojo", password: "Raben"}
    users = [user1]
    users = users ++ [user2]
    u1_encrypted = Bcrypt.hash_pwd_salt(user1.password)



    # check = Enum.member?([users],user)
    # IO.puts check
    conn
    |> put_session(:curr_user_uname, user.username)
    |> render("test.html", _csrf_token: _csrf_token, user: user, users: users, check: check_if_user(user, users), good: Bcrypt.verify_pass(password, u1_encrypted), user_list: user_list)
    # redirect(conn, to: "/redirect_test")
  end


  def sign_out(conn, _params) do
    conn
    |> delete_session(:curr_user_uname)
    |> put_flash(:info, "Vous vous êtes déconnecté.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
