defmodule PmLogin.Repo.Migrations.CreatePlanified do
  use Ecto.Migration

  def change do
    create table(:planified) do
      add :description, :string
      add :dt_start, :naive_datetime
      add :period, :integer

      timestamps()
    end

  end
end
