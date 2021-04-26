defmodule PmLogin.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :progression, :integer
      add :date_start, :date
      add :date_end, :date
      add :estimated_duration, :integer
      add :performed_duration, :integer
      add :deadline, :date
      add :parent_id, references(:tasks, on_delete: :delete_all)
      add :project_id, references(:projects, on_delete: :delete_all)
      add :contributor_id, references(:users, on_delete: :nothing)
      add :status_id, references(:statuses, on_delete: :nothing)
      add :priority_id, references(:priorities, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:parent_id])
    create index(:tasks, [:project_id])
    create index(:tasks, [:contributor_id])
    create index(:tasks, [:status_id])
    create index(:tasks, [:priority_id])
  end
end
