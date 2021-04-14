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
end
