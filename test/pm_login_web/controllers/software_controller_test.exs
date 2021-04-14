defmodule PmLoginWeb.SoftwareControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Services

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:software) do
    {:ok, software} = Services.create_software(@create_attrs)
    software
  end

  describe "index" do
    test "lists all softwares", %{conn: conn} do
      conn = get(conn, Routes.software_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Softwares"
    end
  end

  describe "new software" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.software_path(conn, :new))
      assert html_response(conn, 200) =~ "New Software"
    end
  end

  describe "create software" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.software_path(conn, :create), software: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.software_path(conn, :show, id)

      conn = get(conn, Routes.software_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Software"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.software_path(conn, :create), software: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Software"
    end
  end

  describe "edit software" do
    setup [:create_software]

    test "renders form for editing chosen software", %{conn: conn, software: software} do
      conn = get(conn, Routes.software_path(conn, :edit, software))
      assert html_response(conn, 200) =~ "Edit Software"
    end
  end

  describe "update software" do
    setup [:create_software]

    test "redirects when data is valid", %{conn: conn, software: software} do
      conn = put(conn, Routes.software_path(conn, :update, software), software: @update_attrs)
      assert redirected_to(conn) == Routes.software_path(conn, :show, software)

      conn = get(conn, Routes.software_path(conn, :show, software))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, software: software} do
      conn = put(conn, Routes.software_path(conn, :update, software), software: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Software"
    end
  end

  describe "delete software" do
    setup [:create_software]

    test "deletes chosen software", %{conn: conn, software: software} do
      conn = delete(conn, Routes.software_path(conn, :delete, software))
      assert redirected_to(conn) == Routes.software_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.software_path(conn, :show, software))
      end
    end
  end

  defp create_software(_) do
    software = fixture(:software)
    %{software: software}
  end
end
