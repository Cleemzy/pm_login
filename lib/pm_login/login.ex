defmodule PmLogin.Login do
  @moduledoc """
  The Login context.
  """

  import Ecto.Query, warn: false
  alias PmLogin.Repo

  alias PmLogin.Login.Right

  @doc """
  Returns the list of rights.

  ## Examples

      iex> list_rights()
      [%Right{}, ...]

  """
  def list_rights do
    Repo.all(Right)
  end

  @doc """
  Gets a single right.

  Raises `Ecto.NoResultsError` if the Right does not exist.

  ## Examples

      iex> get_right!(123)
      %Right{}

      iex> get_right!(456)
      ** (Ecto.NoResultsError)

  """
  def get_right!(id), do: Repo.get!(Right, id)

  @doc """
  Creates a right.

  ## Examples

      iex> create_right(%{field: value})
      {:ok, %Right{}}

      iex> create_right(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_right(attrs \\ %{}) do
    %Right{}
    |> Right.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a right.

  ## Examples

      iex> update_right(right, %{field: new_value})
      {:ok, %Right{}}

      iex> update_right(right, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_right(%Right{} = right, attrs) do
    right
    |> Right.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a right.

  ## Examples

      iex> delete_right(right)
      {:ok, %Right{}}

      iex> delete_right(right)
      {:error, %Ecto.Changeset{}}

  """
  def delete_right(%Right{} = right) do
    Repo.delete(right)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking right changes.

  ## Examples

      iex> change_right(right)
      %Ecto.Changeset{data: %Right{}}

  """
  def change_right(%Right{} = right, attrs \\ %{}) do
    Right.changeset(right, attrs)
  end

  alias PmLogin.Login.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_profile_picture(id) do
    user = get_user!(id)
    profile_picture = user.profile_picture
  end

  def get_username(id) do
    user = get_user!(id)
    username = user.username
  end
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def log_user(attrs \\ %{}) do
    %User{}
    |> User.authenticate(attrs)
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.right_changeset(attrs)
    |> Repo.update()
  end

  def update_profile(%User{} = user, attrs) do
    user
    |> User.profile_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias PmLogin.Login.Auth

  def list_all_auth do
    Repo.all(Auth)
  end

  def get_auth!(id), do: Repo.get_by(Auth, id: "#{id}")


end
