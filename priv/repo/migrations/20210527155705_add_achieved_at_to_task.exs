defmodule PmLogin.Repo.Migrations.AddAchievedAtToTask do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :achieved_at, :naive_datetime
    end
  end
end
