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

  describe "users" do
    alias PmLogin.Login.User

    @valid_attrs %{email: "some email", password: "some password", profile_picture: "some profile_picture", username: "some username"}
    @update_attrs %{email: "some updated email", password: "some updated password", profile_picture: "some updated profile_picture", username: "some updated username"}
    @invalid_attrs %{email: nil, password: nil, profile_picture: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Login.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Login.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Login.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Login.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.profile_picture == "some profile_picture"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Login.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Login.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.profile_picture == "some updated profile_picture"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Login.update_user(user, @invalid_attrs)
      assert user == Login.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Login.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Login.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Login.change_user(user)
    end
  end
end
