defmodule PmLogin.LoginTest do
  use PmLogin.DataCase

  alias PmLogin.Login

  describe "rights" do
    alias PmLogin.Login.Right

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def right_fixture(attrs \\ %{}) do
      {:ok, right} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Login.create_right()

      right
    end

    test "list_rights/0 returns all rights" do
      right = right_fixture()
      assert Login.list_rights() == [right]
    end

    test "get_right!/1 returns the right with given id" do
      right = right_fixture()
      assert Login.get_right!(right.id) == right
    end

    test "create_right/1 with valid data creates a right" do
      assert {:ok, %Right{} = right} = Login.create_right(@valid_attrs)
      assert right.title == "some title"
    end

    test "create_right/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Login.create_right(@invalid_attrs)
    end

    test "update_right/2 with valid data updates the right" do
      right = right_fixture()
      assert {:ok, %Right{} = right} = Login.update_right(right, @update_attrs)
      assert right.title == "some updated title"
    end

    test "update_right/2 with invalid data returns error changeset" do
      right = right_fixture()
      assert {:error, %Ecto.Changeset{}} = Login.update_right(right, @invalid_attrs)
      assert right == Login.get_right!(right.id)
    end

    test "delete_right/1 deletes the right" do
      right = right_fixture()
      assert {:ok, %Right{}} = Login.delete_right(right)
      assert_raise Ecto.NoResultsError, fn -> Login.get_right!(right.id) end
    end

    test "change_right/1 returns a right changeset" do
      right = right_fixture()
      assert %Ecto.Changeset{} = Login.change_right(right)
    end
  end
end
