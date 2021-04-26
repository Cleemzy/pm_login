defmodule PmLogin.Monitoring.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :date_end, :date
    field :date_start, :date
    field :deadline, :date
    field :estimated_duration, :integer
    field :performed_duration, :integer
    field :progression, :integer
    field :title, :string
    field :parent_id, :id
    field :project_id, :id
    field :contributor_id, :id
    field :status_id, :id
    field :priority_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline])
    |> validate_required([:title, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline])
  end
end
