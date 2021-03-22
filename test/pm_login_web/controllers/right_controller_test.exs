defmodule PmLoginWeb.RightControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Login

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:right) do
    {:ok, right} = Login.create_right(@create_attrs)
    right
  end

  describe "index" do
    test "lists all rights", %{conn: conn} do
      conn = get(conn, Routes.right_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rights"
    end
  end

  describe "new right" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.right_path(conn, :new))
      assert html_response(conn, 200) =~ "New Right"
    end
  end

  describe "create right" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.right_path(conn, :create), right: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.right_path(conn, :show, id)

      conn = get(conn, Routes.right_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Right"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.right_path(conn, :create), right: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Right"
    end
  end

  describe "edit right" do
    setup [:create_right]

    test "renders form for editing chosen right", %{conn: conn, right: right} do
      conn = get(conn, Routes.right_path(conn, :edit, right))
      assert html_response(conn, 200) =~ "Edit Right"
    end
  end

  describe "update right" do
    setup [:create_right]

    test "redirects when data is valid", %{conn: conn, right: right} do
      conn = put(conn, Routes.right_path(conn, :update, right), right: @update_attrs)
      assert redirected_to(conn) == Routes.right_path(conn, :show, right)

      conn = get(conn, Routes.right_path(conn, :show, right))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, right: right} do
      conn = put(conn, Routes.right_path(conn, :update, right), right: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Right"
    end
  end

  describe "delete right" do
    setup [:create_right]

    test "deletes chosen right", %{conn: conn, right: right} do
      conn = delete(conn, Routes.right_path(conn, :delete, right))
      assert redirected_to(conn) == Routes.right_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.right_path(conn, :show, right))
      end
    end
  end

  defp create_right(_) do
    right = fixture(:right)
    %{right: right}
  end
end
