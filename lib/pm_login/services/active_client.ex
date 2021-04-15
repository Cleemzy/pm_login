defmodule PmLogin.Services.ActiveClient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "active_clients" do
    field :user_id, :id
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(active_client, attrs) do
    active_client
    |> cast(attrs, [])
    |> validate_required([])
  end
end
