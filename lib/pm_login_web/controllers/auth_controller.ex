defmodule PmLoginWeb.AuthController do
  use PmLoginWeb, :controller

  def auth(conn, %{"_csrf_token" => _csrf_token, "username" => username, "password" => password}) do
    encrypted = :crypto.hash(:sha256, password)
    render(conn, "test.html", _csrf_token: _csrf_token, username: username, password: encrypted)
  end
end
