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

  def check(str, list) do
    for u <- list do
      str === u.username
    end
  end

  def auth(conn, %{"_csrf_token" => _csrf_token, "username" => username, "password" => password}) do
    encrypted = :crypto.hash(:sha256, password)
    user = %User{username: username, password: encrypted}

    user1 = %User{username: "Paul", password: "Mazoto"}
    user2 = %User{username: "Rojo", password: "Raben"}
    users = [user1]
    users = users ++ [user2]


    # check = Enum.member?([users],user)
    # IO.puts check
    render(conn, "test.html", _csrf_token: _csrf_token, user: user, users: users)
    # redirect(conn, to: "/redirect_test")
  end
end
