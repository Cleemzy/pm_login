defmodule PmLogin.Services.License do
  use Ecto.Schema
  import Ecto.Changeset

  schema "licenses" do
    field :date_end, :date
    field :date_start, :date
    field :title, :string
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(license, attrs) do
    license
    |> cast(attrs, [:title, :date_start, :date_end])
    |> validate_required([:title, :date_start, :date_end])
  end
end
