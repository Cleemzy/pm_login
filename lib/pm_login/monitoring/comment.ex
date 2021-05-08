defmodule PmLogin.Monitoring.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmLogin.Login.User

  schema "comments" do
    field :content, :string
    field :task_id, :id
    # field :poster_id, :id

    belongs_to :poster, User
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end

  def create_changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :poster_id, :task_id])
    |> validate_required([:content])
  end
end
