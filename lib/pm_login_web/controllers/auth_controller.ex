defmodule PmLoginWeb.AuthController do
  use PmLoginWeb, :controller


  defmodule User do
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



  defp check_if_user(%User{} = u, list) do
    usernames = Enum.map(list, fn %User{} = user -> user.username end )
    Enum.member?(usernames, u.username)
  end

  def auth(conn, %{"_csrf_token" => _csrf_token, "username" => username, "password" => password}) do
    # encrypted = :crypto.hash(:sha256, password)
    encrypted = Bcrypt.hash_pwd_salt(password)
    user = %User{username: username, password: encrypted}

    user1 = %User{username: "Paul", password: "Mazoto"}
    user2 = %User{username: "Rojo", password: "Raben"}
    users = [user1]
    users = users ++ [user2]
    u1_encrypted = Bcrypt.hash_pwd_salt(user1.password)

    # check = Enum.member?([users],user)
    # IO.puts check
    render(conn, "test.html", _csrf_token: _csrf_token, user: user, users: users, check: check_if_user(user, users), good: Bcrypt.verify_pass(password, u1_encrypted))
    # redirect(conn, to: "/redirect_test")
  end
end
