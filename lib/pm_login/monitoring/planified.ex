defmodule PmLogin.Monitoring.Planified do
  use Ecto.Schema
  import Ecto.Changeset

  schema "planified" do
    field :description, :string
    field :dt_start, :naive_datetime
    field :period, :integer
    field :attributor_id, :integer
    field :contributor_id, :integer
    field :project_id, :integer
    field :estimated_duration, :integer
    field :without_control, :boolean, default: false

    timestamps()
  end

  @doc false
  def create_changeset(planified, attrs) do
    planified
    |> cast(attrs, [:description, :dt_start, :period, :project_id, :attributor_id, :contributor_id, :estimated_duration, :without_control])
    |> validate_required(:description, message: "Entrez description de tâche")
    |> validate_required(:dt_start, message: "Entrez la date de début de la tâche planifiée")
    |> validate_required(:period, message: "Entrez période de planification")
  end

  def changeset(planified, attrs) do
    planified
    |> cast(attrs, [:description, :dt_start, :period, :project_id, :attributor_id, :contributor_id, :estimated_duration, :without_control])
  end

  #CREATION SAMPLES
  #day = NaiveDateTime.new(~D[2010-10-02], ~T[12:00:00.000])
  # Monitoring.create_planified(%{description: "Tâche planifiée 3",
  #                               dt_start: the_day, period: 2, project_id: 24, attributor_id: 57,
  #                               estimated_duration: 2, without_control: false})
end
