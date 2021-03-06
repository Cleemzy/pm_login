defmodule PmLogin.ServicesTest do
  use PmLogin.DataCase

  alias PmLogin.Services

  describe "companies" do
    alias PmLogin.Services.Company

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Services.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Services.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Services.create_company(@valid_attrs)
      assert company.name == "some name"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Services.update_company(company, @update_attrs)
      assert company.name == "some updated name"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_company(company, @invalid_attrs)
      assert company == Services.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Services.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Services.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Services.change_company(company)
    end
  end

  describe "softwares" do
    alias PmLogin.Services.Software

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def software_fixture(attrs \\ %{}) do
      {:ok, software} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_software()

      software
    end

    test "list_softwares/0 returns all softwares" do
      software = software_fixture()
      assert Services.list_softwares() == [software]
    end

    test "get_software!/1 returns the software with given id" do
      software = software_fixture()
      assert Services.get_software!(software.id) == software
    end

    test "create_software/1 with valid data creates a software" do
      assert {:ok, %Software{} = software} = Services.create_software(@valid_attrs)
      assert software.title == "some title"
    end

    test "create_software/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_software(@invalid_attrs)
    end

    test "update_software/2 with valid data updates the software" do
      software = software_fixture()
      assert {:ok, %Software{} = software} = Services.update_software(software, @update_attrs)
      assert software.title == "some updated title"
    end

    test "update_software/2 with invalid data returns error changeset" do
      software = software_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_software(software, @invalid_attrs)
      assert software == Services.get_software!(software.id)
    end

    test "delete_software/1 deletes the software" do
      software = software_fixture()
      assert {:ok, %Software{}} = Services.delete_software(software)
      assert_raise Ecto.NoResultsError, fn -> Services.get_software!(software.id) end
    end

    test "change_software/1 returns a software changeset" do
      software = software_fixture()
      assert %Ecto.Changeset{} = Services.change_software(software)
    end
  end

  describe "editors" do
    alias PmLogin.Services.Editor

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def editor_fixture(attrs \\ %{}) do
      {:ok, editor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_editor()

      editor
    end

    test "list_editors/0 returns all editors" do
      editor = editor_fixture()
      assert Services.list_editors() == [editor]
    end

    test "get_editor!/1 returns the editor with given id" do
      editor = editor_fixture()
      assert Services.get_editor!(editor.id) == editor
    end

    test "create_editor/1 with valid data creates a editor" do
      assert {:ok, %Editor{} = editor} = Services.create_editor(@valid_attrs)
      assert editor.title == "some title"
    end

    test "create_editor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_editor(@invalid_attrs)
    end

    test "update_editor/2 with valid data updates the editor" do
      editor = editor_fixture()
      assert {:ok, %Editor{} = editor} = Services.update_editor(editor, @update_attrs)
      assert editor.title == "some updated title"
    end

    test "update_editor/2 with invalid data returns error changeset" do
      editor = editor_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_editor(editor, @invalid_attrs)
      assert editor == Services.get_editor!(editor.id)
    end

    test "delete_editor/1 deletes the editor" do
      editor = editor_fixture()
      assert {:ok, %Editor{}} = Services.delete_editor(editor)
      assert_raise Ecto.NoResultsError, fn -> Services.get_editor!(editor.id) end
    end

    test "change_editor/1 returns a editor changeset" do
      editor = editor_fixture()
      assert %Ecto.Changeset{} = Services.change_editor(editor)
    end
  end

  describe "licenses" do
    alias PmLogin.Services.License

    @valid_attrs %{date_end: ~D[2010-04-17], date_start: ~D[2010-04-17], title: "some title"}
    @update_attrs %{date_end: ~D[2011-05-18], date_start: ~D[2011-05-18], title: "some updated title"}
    @invalid_attrs %{date_end: nil, date_start: nil, title: nil}

    def license_fixture(attrs \\ %{}) do
      {:ok, license} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_license()

      license
    end

    test "list_licenses/0 returns all licenses" do
      license = license_fixture()
      assert Services.list_licenses() == [license]
    end

    test "get_license!/1 returns the license with given id" do
      license = license_fixture()
      assert Services.get_license!(license.id) == license
    end

    test "create_license/1 with valid data creates a license" do
      assert {:ok, %License{} = license} = Services.create_license(@valid_attrs)
      assert license.date_end == ~D[2010-04-17]
      assert license.date_start == ~D[2010-04-17]
      assert license.title == "some title"
    end

    test "create_license/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_license(@invalid_attrs)
    end

    test "update_license/2 with valid data updates the license" do
      license = license_fixture()
      assert {:ok, %License{} = license} = Services.update_license(license, @update_attrs)
      assert license.date_end == ~D[2011-05-18]
      assert license.date_start == ~D[2011-05-18]
      assert license.title == "some updated title"
    end

    test "update_license/2 with invalid data returns error changeset" do
      license = license_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_license(license, @invalid_attrs)
      assert license == Services.get_license!(license.id)
    end

    test "delete_license/1 deletes the license" do
      license = license_fixture()
      assert {:ok, %License{}} = Services.delete_license(license)
      assert_raise Ecto.NoResultsError, fn -> Services.get_license!(license.id) end
    end

    test "change_license/1 returns a license changeset" do
      license = license_fixture()
      assert %Ecto.Changeset{} = Services.change_license(license)
    end
  end

  describe "assist_contracts" do
    alias PmLogin.Services.AssistContract

    @valid_attrs %{date_end: ~D[2010-04-17], date_start: ~D[2010-04-17], title: "some title"}
    @update_attrs %{date_end: ~D[2011-05-18], date_start: ~D[2011-05-18], title: "some updated title"}
    @invalid_attrs %{date_end: nil, date_start: nil, title: nil}

    def assist_contract_fixture(attrs \\ %{}) do
      {:ok, assist_contract} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_assist_contract()

      assist_contract
    end

    test "list_assist_contracts/0 returns all assist_contracts" do
      assist_contract = assist_contract_fixture()
      assert Services.list_assist_contracts() == [assist_contract]
    end

    test "get_assist_contract!/1 returns the assist_contract with given id" do
      assist_contract = assist_contract_fixture()
      assert Services.get_assist_contract!(assist_contract.id) == assist_contract
    end

    test "create_assist_contract/1 with valid data creates a assist_contract" do
      assert {:ok, %AssistContract{} = assist_contract} = Services.create_assist_contract(@valid_attrs)
      assert assist_contract.date_end == ~D[2010-04-17]
      assert assist_contract.date_start == ~D[2010-04-17]
      assert assist_contract.title == "some title"
    end

    test "create_assist_contract/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_assist_contract(@invalid_attrs)
    end

    test "update_assist_contract/2 with valid data updates the assist_contract" do
      assist_contract = assist_contract_fixture()
      assert {:ok, %AssistContract{} = assist_contract} = Services.update_assist_contract(assist_contract, @update_attrs)
      assert assist_contract.date_end == ~D[2011-05-18]
      assert assist_contract.date_start == ~D[2011-05-18]
      assert assist_contract.title == "some updated title"
    end

    test "update_assist_contract/2 with invalid data returns error changeset" do
      assist_contract = assist_contract_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_assist_contract(assist_contract, @invalid_attrs)
      assert assist_contract == Services.get_assist_contract!(assist_contract.id)
    end

    test "delete_assist_contract/1 deletes the assist_contract" do
      assist_contract = assist_contract_fixture()
      assert {:ok, %AssistContract{}} = Services.delete_assist_contract(assist_contract)
      assert_raise Ecto.NoResultsError, fn -> Services.get_assist_contract!(assist_contract.id) end
    end

    test "change_assist_contract/1 returns a assist_contract changeset" do
      assist_contract = assist_contract_fixture()
      assert %Ecto.Changeset{} = Services.change_assist_contract(assist_contract)
    end
  end

  describe "active_clients" do
    alias PmLogin.Services.ActiveClient

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def active_client_fixture(attrs \\ %{}) do
      {:ok, active_client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_active_client()

      active_client
    end

    test "list_active_clients/0 returns all active_clients" do
      active_client = active_client_fixture()
      assert Services.list_active_clients() == [active_client]
    end

    test "get_active_client!/1 returns the active_client with given id" do
      active_client = active_client_fixture()
      assert Services.get_active_client!(active_client.id) == active_client
    end

    test "create_active_client/1 with valid data creates a active_client" do
      assert {:ok, %ActiveClient{} = active_client} = Services.create_active_client(@valid_attrs)
    end

    test "create_active_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_active_client(@invalid_attrs)
    end

    test "update_active_client/2 with valid data updates the active_client" do
      active_client = active_client_fixture()
      assert {:ok, %ActiveClient{} = active_client} = Services.update_active_client(active_client, @update_attrs)
    end

    test "update_active_client/2 with invalid data returns error changeset" do
      active_client = active_client_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_active_client(active_client, @invalid_attrs)
      assert active_client == Services.get_active_client!(active_client.id)
    end

    test "delete_active_client/1 deletes the active_client" do
      active_client = active_client_fixture()
      assert {:ok, %ActiveClient{}} = Services.delete_active_client(active_client)
      assert_raise Ecto.NoResultsError, fn -> Services.get_active_client!(active_client.id) end
    end

    test "change_active_client/1 returns a active_client changeset" do
      active_client = active_client_fixture()
      assert %Ecto.Changeset{} = Services.change_active_client(active_client)
    end
  end

  describe "clients_requests" do
    alias PmLogin.Services.ClientsRequest

    @valid_attrs %{date_post: ~N[2010-04-17 14:00:00]}
    @update_attrs %{date_post: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{date_post: nil}

    def clients_request_fixture(attrs \\ %{}) do
      {:ok, clients_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_clients_request()

      clients_request
    end

    test "list_clients_requests/0 returns all clients_requests" do
      clients_request = clients_request_fixture()
      assert Services.list_clients_requests() == [clients_request]
    end

    test "get_clients_request!/1 returns the clients_request with given id" do
      clients_request = clients_request_fixture()
      assert Services.get_clients_request!(clients_request.id) == clients_request
    end

    test "create_clients_request/1 with valid data creates a clients_request" do
      assert {:ok, %ClientsRequest{} = clients_request} = Services.create_clients_request(@valid_attrs)
      assert clients_request.date_post == ~N[2010-04-17 14:00:00]
    end

    test "create_clients_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_clients_request(@invalid_attrs)
    end

    test "update_clients_request/2 with valid data updates the clients_request" do
      clients_request = clients_request_fixture()
      assert {:ok, %ClientsRequest{} = clients_request} = Services.update_clients_request(clients_request, @update_attrs)
      assert clients_request.date_post == ~N[2011-05-18 15:01:01]
    end

    test "update_clients_request/2 with invalid data returns error changeset" do
      clients_request = clients_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_clients_request(clients_request, @invalid_attrs)
      assert clients_request == Services.get_clients_request!(clients_request.id)
    end

    test "delete_clients_request/1 deletes the clients_request" do
      clients_request = clients_request_fixture()
      assert {:ok, %ClientsRequest{}} = Services.delete_clients_request(clients_request)
      assert_raise Ecto.NoResultsError, fn -> Services.get_clients_request!(clients_request.id) end
    end

    test "change_clients_request/1 returns a clients_request changeset" do
      clients_request = clients_request_fixture()
      assert %Ecto.Changeset{} = Services.change_clients_request(clients_request)
    end
  end

  describe "clients_requests" do
    alias PmLogin.Services.ClientsRequest

    @valid_attrs %{content: "some content", date_post: ~N[2010-04-17 14:00:00]}
    @update_attrs %{content: "some updated content", date_post: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{content: nil, date_post: nil}

    def clients_request_fixture(attrs \\ %{}) do
      {:ok, clients_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_clients_request()

      clients_request
    end

    test "list_clients_requests/0 returns all clients_requests" do
      clients_request = clients_request_fixture()
      assert Services.list_clients_requests() == [clients_request]
    end

    test "get_clients_request!/1 returns the clients_request with given id" do
      clients_request = clients_request_fixture()
      assert Services.get_clients_request!(clients_request.id) == clients_request
    end

    test "create_clients_request/1 with valid data creates a clients_request" do
      assert {:ok, %ClientsRequest{} = clients_request} = Services.create_clients_request(@valid_attrs)
      assert clients_request.content == "some content"
      assert clients_request.date_post == ~N[2010-04-17 14:00:00]
    end

    test "create_clients_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_clients_request(@invalid_attrs)
    end

    test "update_clients_request/2 with valid data updates the clients_request" do
      clients_request = clients_request_fixture()
      assert {:ok, %ClientsRequest{} = clients_request} = Services.update_clients_request(clients_request, @update_attrs)
      assert clients_request.content == "some updated content"
      assert clients_request.date_post == ~N[2011-05-18 15:01:01]
    end

    test "update_clients_request/2 with invalid data returns error changeset" do
      clients_request = clients_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_clients_request(clients_request, @invalid_attrs)
      assert clients_request == Services.get_clients_request!(clients_request.id)
    end

    test "delete_clients_request/1 deletes the clients_request" do
      clients_request = clients_request_fixture()
      assert {:ok, %ClientsRequest{}} = Services.delete_clients_request(clients_request)
      assert_raise Ecto.NoResultsError, fn -> Services.get_clients_request!(clients_request.id) end
    end

    test "change_clients_request/1 returns a clients_request changeset" do
      clients_request = clients_request_fixture()
      assert %Ecto.Changeset{} = Services.change_clients_request(clients_request)
    end
  end

  describe "notifications" do
    alias PmLogin.Services.Notification

    @valid_attrs %{content: "some content", seen: true}
    @update_attrs %{content: "some updated content", seen: false}
    @invalid_attrs %{content: nil, seen: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Services.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Services.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Services.create_notification(@valid_attrs)
      assert notification.content == "some content"
      assert notification.seen == true
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{} = notification} = Services.update_notification(notification, @update_attrs)
      assert notification.content == "some updated content"
      assert notification.seen == false
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_notification(notification, @invalid_attrs)
      assert notification == Services.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Services.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Services.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Services.change_notification(notification)
    end
  end
end
