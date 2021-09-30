defmodule PmLogin.Monitoring.Planified do
  use Ecto.Schema
  import Ecto.Changeset

  schema "planified" do
    field :description, :string
    field :dt_start, :naive_datetime
    field :period, :integer

    timestamps()
  end

  @doc false
  def create_changeset(planified, attrs) do
    planified
    |> cast(attrs, [:description, :dt_start, :period])
    # |> validate_required([:description, :dt_start, :period])
    |> validate_required(:description, message: "Entrez description de tâche")
    |> validate_required(:dt_start, message: "Entrez la date de début de la tâche planifiée")
    |> validate_required(:period, message: "Entrez période de planification")
  end
end
