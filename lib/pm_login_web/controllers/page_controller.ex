defmodule PmLoginWeb.PageController do
  use PmLoginWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", layout: {PmLoginWeb.LayoutView, "login_layout.html"})
  end
end
