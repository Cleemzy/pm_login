defmodule PmLoginWeb.LicenseControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Services

  @create_attrs %{date_end: ~D[2010-04-17], date_start: ~D[2010-04-17], title: "some title"}
  @update_attrs %{date_end: ~D[2011-05-18], date_start: ~D[2011-05-18], title: "some updated title"}
  @invalid_attrs %{date_end: nil, date_start: nil, title: nil}

  def fixture(:license) do
    {:ok, license} = Services.create_license(@create_attrs)
    license
  end

  describe "index" do
    test "lists all licenses", %{conn: conn} do
      conn = get(conn, Routes.license_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Licenses"
    end
  end

  describe "new license" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.license_path(conn, :new))
      assert html_response(conn, 200) =~ "New License"
    end
  end

  describe "create license" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.license_path(conn, :create), license: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.license_path(conn, :show, id)

      conn = get(conn, Routes.license_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show License"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.license_path(conn, :create), license: @invalid_attrs)
      assert html_response(conn, 200) =~ "New License"
    end
  end

  describe "edit license" do
    setup [:create_license]

    test "renders form for editing chosen license", %{conn: conn, license: license} do
      conn = get(conn, Routes.license_path(conn, :edit, license))
      assert html_response(conn, 200) =~ "Edit License"
    end
  end

  describe "update license" do
    setup [:create_license]

    test "redirects when data is valid", %{conn: conn, license: license} do
      conn = put(conn, Routes.license_path(conn, :update, license), license: @update_attrs)
      assert redirected_to(conn) == Routes.license_path(conn, :show, license)

      conn = get(conn, Routes.license_path(conn, :show, license))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, license: license} do
      conn = put(conn, Routes.license_path(conn, :update, license), license: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit License"
    end
  end

  describe "delete license" do
    setup [:create_license]

    test "deletes chosen license", %{conn: conn, license: license} do
      conn = delete(conn, Routes.license_path(conn, :delete, license))
      assert redirected_to(conn) == Routes.license_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.license_path(conn, :show, license))
      end
    end
  end

  defp create_license(_) do
    license = fixture(:license)
    %{license: license}
  end
end
