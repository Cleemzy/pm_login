defmodule PmLogin.Services.Editor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "editors" do
    field :title, :string
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(editor, attrs) do
    editor
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
