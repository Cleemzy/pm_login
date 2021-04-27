defmodule PmLogin.Services.ActiveClient do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmLogin.Login.User

  schema "active_clients" do
    # field :user_id, :id
    field :company_id, :id
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(active_client, attrs) do
    active_client
    |> cast(attrs, [])
    |> validate_required([])
  end

  def create_changeset(active_client, attrs) do
    active_client
    |> cast(attrs, [:user_id, :company_id])
    |> validate_required([])
  end
end
