defmodule PmLoginWeb.PriorityControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Monitoring

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:priority) do
    {:ok, priority} = Monitoring.create_priority(@create_attrs)
    priority
  end

  describe "index" do
    test "lists all priorities", %{conn: conn} do
      conn = get(conn, Routes.priority_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Priorities"
    end
  end

  describe "new priority" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.priority_path(conn, :new))
      assert html_response(conn, 200) =~ "New Priority"
    end
  end

  describe "create priority" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.priority_path(conn, :create), priority: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.priority_path(conn, :show, id)

      conn = get(conn, Routes.priority_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Priority"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.priority_path(conn, :create), priority: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Priority"
    end
  end

  describe "edit priority" do
    setup [:create_priority]

    test "renders form for editing chosen priority", %{conn: conn, priority: priority} do
      conn = get(conn, Routes.priority_path(conn, :edit, priority))
      assert html_response(conn, 200) =~ "Edit Priority"
    end
  end

  describe "update priority" do
    setup [:create_priority]

    test "redirects when data is valid", %{conn: conn, priority: priority} do
      conn = put(conn, Routes.priority_path(conn, :update, priority), priority: @update_attrs)
      assert redirected_to(conn) == Routes.priority_path(conn, :show, priority)

      conn = get(conn, Routes.priority_path(conn, :show, priority))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, priority: priority} do
      conn = put(conn, Routes.priority_path(conn, :update, priority), priority: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Priority"
    end
  end

  describe "delete priority" do
    setup [:create_priority]

    test "deletes chosen priority", %{conn: conn, priority: priority} do
      conn = delete(conn, Routes.priority_path(conn, :delete, priority))
      assert redirected_to(conn) == Routes.priority_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.priority_path(conn, :show, priority))
      end
    end
  end

  defp create_priority(_) do
    priority = fixture(:priority)
    %{priority: priority}
  end
end
