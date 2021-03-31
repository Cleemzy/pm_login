defmodule PmLoginWeb.PageController do
  use PmLoginWeb, :controller
  alias PmLogin.Login.User
  alias PmLogin.Login

  def index(conn, _params) do
    changeset = Login.change_user(%User{})
    render(conn, "index.html", changeset: changeset, layout: {PmLoginWeb.LayoutView, "login_layout.html"})
  end
end
