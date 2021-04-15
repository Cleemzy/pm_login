defmodule PmLoginWeb.ActiveClientControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Services

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:active_client) do
    {:ok, active_client} = Services.create_active_client(@create_attrs)
    active_client
  end

  describe "index" do
    test "lists all active_clients", %{conn: conn} do
      conn = get(conn, Routes.active_client_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Active clients"
    end
  end

  describe "new active_client" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.active_client_path(conn, :new))
      assert html_response(conn, 200) =~ "New Active client"
    end
  end

  describe "create active_client" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.active_client_path(conn, :create), active_client: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.active_client_path(conn, :show, id)

      conn = get(conn, Routes.active_client_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Active client"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.active_client_path(conn, :create), active_client: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Active client"
    end
  end

  describe "edit active_client" do
    setup [:create_active_client]

    test "renders form for editing chosen active_client", %{conn: conn, active_client: active_client} do
      conn = get(conn, Routes.active_client_path(conn, :edit, active_client))
      assert html_response(conn, 200) =~ "Edit Active client"
    end
  end

  describe "update active_client" do
    setup [:create_active_client]

    test "redirects when data is valid", %{conn: conn, active_client: active_client} do
      conn = put(conn, Routes.active_client_path(conn, :update, active_client), active_client: @update_attrs)
      assert redirected_to(conn) == Routes.active_client_path(conn, :show, active_client)

      conn = get(conn, Routes.active_client_path(conn, :show, active_client))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, active_client: active_client} do
      conn = put(conn, Routes.active_client_path(conn, :update, active_client), active_client: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Active client"
    end
  end

  describe "delete active_client" do
    setup [:create_active_client]

    test "deletes chosen active_client", %{conn: conn, active_client: active_client} do
      conn = delete(conn, Routes.active_client_path(conn, :delete, active_client))
      assert redirected_to(conn) == Routes.active_client_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.active_client_path(conn, :show, active_client))
      end
    end
  end

  defp create_active_client(_) do
    active_client = fixture(:active_client)
    %{active_client: active_client}
  end
end
