defmodule PmLoginWeb.AssistContractControllerTest do
  use PmLoginWeb.ConnCase

  alias PmLogin.Services

  @create_attrs %{date_end: ~D[2010-04-17], date_start: ~D[2010-04-17], title: "some title"}
  @update_attrs %{date_end: ~D[2011-05-18], date_start: ~D[2011-05-18], title: "some updated title"}
  @invalid_attrs %{date_end: nil, date_start: nil, title: nil}

  def fixture(:assist_contract) do
    {:ok, assist_contract} = Services.create_assist_contract(@create_attrs)
    assist_contract
  end

  describe "index" do
    test "lists all assist_contracts", %{conn: conn} do
      conn = get(conn, Routes.assist_contract_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Assist contracts"
    end
  end

  describe "new assist_contract" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.assist_contract_path(conn, :new))
      assert html_response(conn, 200) =~ "New Assist contract"
    end
  end

  describe "create assist_contract" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.assist_contract_path(conn, :create), assist_contract: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.assist_contract_path(conn, :show, id)

      conn = get(conn, Routes.assist_contract_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Assist contract"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assist_contract_path(conn, :create), assist_contract: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Assist contract"
    end
  end

  describe "edit assist_contract" do
    setup [:create_assist_contract]

    test "renders form for editing chosen assist_contract", %{conn: conn, assist_contract: assist_contract} do
      conn = get(conn, Routes.assist_contract_path(conn, :edit, assist_contract))
      assert html_response(conn, 200) =~ "Edit Assist contract"
    end
  end

  describe "update assist_contract" do
    setup [:create_assist_contract]

    test "redirects when data is valid", %{conn: conn, assist_contract: assist_contract} do
      conn = put(conn, Routes.assist_contract_path(conn, :update, assist_contract), assist_contract: @update_attrs)
      assert redirected_to(conn) == Routes.assist_contract_path(conn, :show, assist_contract)

      conn = get(conn, Routes.assist_contract_path(conn, :show, assist_contract))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, assist_contract: assist_contract} do
      conn = put(conn, Routes.assist_contract_path(conn, :update, assist_contract), assist_contract: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Assist contract"
    end
  end

  describe "delete assist_contract" do
    setup [:create_assist_contract]

    test "deletes chosen assist_contract", %{conn: conn, assist_contract: assist_contract} do
      conn = delete(conn, Routes.assist_contract_path(conn, :delete, assist_contract))
      assert redirected_to(conn) == Routes.assist_contract_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.assist_contract_path(conn, :show, assist_contract))
      end
    end
  end

  defp create_assist_contract(_) do
    assist_contract = fixture(:assist_contract)
    %{assist_contract: assist_contract}
  end
end
