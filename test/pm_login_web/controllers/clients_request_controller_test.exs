defmodule PmLoginWeb.ClientsRequestControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Services

  @create_attrs %{content: "some content", date_post: ~N[2010-04-17 14:00:00]}
  @update_attrs %{content: "some updated content", date_post: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{content: nil, date_post: nil}

  def fixture(:clients_request) do
    {:ok, clients_request} = Services.create_clients_request(@create_attrs)
    clients_request
  end

  describe "index" do
    test "lists all clients_requests", %{conn: conn} do
      conn = get(conn, Routes.clients_request_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Clients requests"
    end
  end

  describe "new clients_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.clients_request_path(conn, :new))
      assert html_response(conn, 200) =~ "New Clients request"
    end
  end

  describe "create clients_request" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.clients_request_path(conn, :create), clients_request: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.clients_request_path(conn, :show, id)

      conn = get(conn, Routes.clients_request_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Clients request"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.clients_request_path(conn, :create), clients_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Clients request"
    end
  end

  describe "edit clients_request" do
    setup [:create_clients_request]

    test "renders form for editing chosen clients_request", %{conn: conn, clients_request: clients_request} do
      conn = get(conn, Routes.clients_request_path(conn, :edit, clients_request))
      assert html_response(conn, 200) =~ "Edit Clients request"
    end
  end

  describe "update clients_request" do
    setup [:create_clients_request]

    test "redirects when data is valid", %{conn: conn, clients_request: clients_request} do
      conn = put(conn, Routes.clients_request_path(conn, :update, clients_request), clients_request: @update_attrs)
      assert redirected_to(conn) == Routes.clients_request_path(conn, :show, clients_request)

      conn = get(conn, Routes.clients_request_path(conn, :show, clients_request))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, clients_request: clients_request} do
      conn = put(conn, Routes.clients_request_path(conn, :update, clients_request), clients_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Clients request"
    end
  end

  describe "delete clients_request" do
    setup [:create_clients_request]

    test "deletes chosen clients_request", %{conn: conn, clients_request: clients_request} do
      conn = delete(conn, Routes.clients_request_path(conn, :delete, clients_request))
      assert redirected_to(conn) == Routes.clients_request_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.clients_request_path(conn, :show, clients_request))
      end
    end
  end

  defp create_clients_request(_) do
    clients_request = fixture(:clients_request)
    %{clients_request: clients_request}
  end
end
