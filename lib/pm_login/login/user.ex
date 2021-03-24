defmodule PmLogin.Login.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :profile_picture, :string
    field :username, :string
    field :right_id, :id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :profile_picture, :email, :password])
    |> validate_required([:username, :profile_picture, :email, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
