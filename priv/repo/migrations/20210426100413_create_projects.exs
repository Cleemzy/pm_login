defmodule PmLogin.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string
      add :description, :string
      add :progression, :integer
      add :date_start, :date
      add :date_end, :date
      add :estimated_duration, :integer
      add :performed_duration, :integer
      add :deadline, :date
      add :active_client_id, references(:active_clients, on_delete: :nothing)
      add :status_id, references(:statuses, on_delete: :nothing)

      timestamps()
    end

    create index(:projects, [:active_client_id])
    create index(:projects, [:status_id])
  end
end
