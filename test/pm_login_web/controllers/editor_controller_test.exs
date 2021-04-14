defmodule PmLoginWeb.EditorControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Services

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:editor) do
    {:ok, editor} = Services.create_editor(@create_attrs)
    editor
  end

  describe "index" do
    test "lists all editors", %{conn: conn} do
      conn = get(conn, Routes.editor_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Editors"
    end
  end

  describe "new editor" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.editor_path(conn, :new))
      assert html_response(conn, 200) =~ "New Editor"
    end
  end

  describe "create editor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.editor_path(conn, :create), editor: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.editor_path(conn, :show, id)

      conn = get(conn, Routes.editor_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Editor"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.editor_path(conn, :create), editor: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Editor"
    end
  end

  describe "edit editor" do
    setup [:create_editor]

    test "renders form for editing chosen editor", %{conn: conn, editor: editor} do
      conn = get(conn, Routes.editor_path(conn, :edit, editor))
      assert html_response(conn, 200) =~ "Edit Editor"
    end
  end

  describe "update editor" do
    setup [:create_editor]

    test "redirects when data is valid", %{conn: conn, editor: editor} do
      conn = put(conn, Routes.editor_path(conn, :update, editor), editor: @update_attrs)
      assert redirected_to(conn) == Routes.editor_path(conn, :show, editor)

      conn = get(conn, Routes.editor_path(conn, :show, editor))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, editor: editor} do
      conn = put(conn, Routes.editor_path(conn, :update, editor), editor: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Editor"
    end
  end

  describe "delete editor" do
    setup [:create_editor]

    test "deletes chosen editor", %{conn: conn, editor: editor} do
      conn = delete(conn, Routes.editor_path(conn, :delete, editor))
      assert redirected_to(conn) == Routes.editor_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.editor_path(conn, :show, editor))
      end
    end
  end

  defp create_editor(_) do
    editor = fixture(:editor)
    %{editor: editor}
  end
end
