defmodule PmLogin.Login do
  @moduledoc """
  The Login context.
  """
  import Plug.Conn
  import Ecto.Query, warn: false
  alias PmLogin.Repo

  alias PmLogin.Login.Right

  @topic inspect(__MODULE__)
  def subscribe do
    Phoenix.PubSub.subscribe(PmLogin.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, @topic, {__MODULE__, event, result})
  end


  @doc """
  Returns the list of rights.

  ## Examples

      iex> list_rights()
      [%Right{}, ...]

  """
  def list_rights do
    Repo.all(Right)
  end

  # select * from rights where rights.id != 7;

  def list_asc_rights do
    query = from r in Right, where: r.id != 5, order_by: [asc: :id] , select: r
    #5 = non attribué
    Repo.all(query)
  end

  def list_rights_without_archived do
    query = from r in Right, where: r.id != 100, select: r
    #0 = archivé
    Repo.all(query)
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
    right
    |> Repo.delete
    |> broadcast_change([:right, :deleted])
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
  checks user status functions
  """

  def is_connected?(conn) do
    get_curr_user_id(conn) != nil
  end

  def get_curr_user(conn) do
    user = get_curr_user_id(conn) |> get_user!
  end

  def get_curr_user_id(conn) do
    current_id = get_session(conn, :curr_user_id)
  end

  def is_admin?(conn) do
    user_id = get_curr_user_id(conn)
    user = get_user!(user_id)
    user.right_id == 1
  end

  def is_attributor?(conn) do
    user_id = get_curr_user_id(conn)
    user = get_user!(user_id)
    user.right_id == 2
  end

  def is_contributor?(conn) do
    user_id = get_curr_user_id(conn)
    user = get_user!(user_id)
    user.right_id == 3
  end

  def is_client?(conn) do
    user_id = get_curr_user_id(conn)
    user = get_user!(user_id)
    user.right_id == 4
  end

  def is_not_attributed?(conn) do
    user_id = get_curr_user_id(conn)
    user = get_user!(user_id)
    user.right_id == 5
  end

  def is_archived?(conn) do
    user_id = get_curr_user_id(conn)
    user = get_user!(user_id)
    user.right_id == 100
  end


  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def restore_user(%User{} = user) do
    params = %{"right_id" => 5}
    user
    |> User.restore_changeset(params)
    |> Repo.update()
  end

  def archive_user(%User{} = user) do
    params = %{"right_id" => 100}
    user
    |> User.archive_changeset(params)
    |> Repo.update()
    |> broadcast_change([:user, :updated])
  end

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

  def filter_auth(right_id) do
    case right_id do
      1 -> list_only_auth_admin
      2 -> list_only_auth_attributor
      3 -> list_only_auth_contributor
      4 -> list_only_auth_client
      5 -> list_only_auth_unattributed
      100 -> list_only_auth_archived
      9000 -> list_asc_auth
    end
  end

  def list_only_auth_admin do
    query = from a in Auth, where: a.right_id == 1,order_by: [asc: :right_id], select: a
    Repo.all(query)
  end

  def list_only_auth_attributor do
    query = from a in Auth, where: a.right_id == 2,order_by: [asc: :right_id], select: a
    Repo.all(query)
  end

  def list_only_auth_contributor do
    query = from a in Auth, where: a.right_id == 3,order_by: [asc: :right_id], select: a
    Repo.all(query)
  end

  def list_only_auth_client do
    query = from a in Auth, where: a.right_id == 4,order_by: [asc: :right_id], select: a
    Repo.all(query)
  end

  def list_only_auth_unattributed do
    query = from a in Auth, where: a.right_id == 5,order_by: [asc: :right_id], select: a
    Repo.all(query)
  end

  def list_only_auth_archived do
    query = from a in Auth, where: a.right_id == 100,order_by: [asc: :right_id], select: a
    Repo.all(query)
  end

  def sort_auth(sort_type) when sort_type == "asc", do: list_asc_username_auth
  def sort_auth(sort_type) when sort_type == "desc", do: list_desc_username_auth 

  def list_asc_username_auth do
    query = from a in Auth, order_by: [asc: :username], select: a
    Repo.all(query)
  end

  def list_desc_username_auth do
    query = from a in Auth, order_by: [desc: :username], select: a
    Repo.all(query)
  end

  def list_asc_auth do
    query = from a in Auth, order_by: [asc: :right_id], select: a
    Repo.all(query)
  end

  def list_all_auth do
    Repo.all(Auth)
  end

  def get_auth!(id), do: Repo.get_by(Auth, id: "#{id}")

end
