defmodule PmLogin.Services.Software do
  use Ecto.Schema
  import Ecto.Changeset

  schema "softwares" do
    field :title, :string
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(software, attrs) do
    software
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
