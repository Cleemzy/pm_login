defmodule PmLogin.Monitoring.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :date_end, :date
    field :date_start, :date
    field :deadline, :date
    field :description, :string
    field :estimated_duration, :integer
    field :performed_duration, :integer
    field :progression, :integer
    field :title, :string
    field :active_client_id, :id
    field :status_id, :id

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :description, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline])
    |> validate_required([:title, :description, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline])
  end
end
