defmodule PmLogin.Login.Right do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rights" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(right, attrs) do
    right
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
