defmodule PmLogin.Services.AssistContract do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assist_contracts" do
    field :date_end, :date
    field :date_start, :date
    field :title, :string
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(assist_contract, attrs) do
    assist_contract
    |> cast(attrs, [:title, :date_start, :date_end])
    |> validate_required([:title, :date_start, :date_end])
  end
end
