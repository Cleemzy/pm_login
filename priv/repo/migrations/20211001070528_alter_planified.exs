defmodule PmLogin.Repo.Migrations.AlterPlanified do
  use Ecto.Migration

  def change do
    alter table("planified") do
      add :attributor_id, :integer
      add :contributor_id, :integer
      add :project_id, :integer
      add :estimated_duration, :integer
      add :without_control, :boolean, default: false
    end
  end
end
