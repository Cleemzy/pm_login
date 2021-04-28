defmodule PmLogin.Repo.Migrations.AddTaskidToCard do
  use Ecto.Migration

  def change do
    alter table("cards") do
      add :task_id, references("tasks")
    end
  end
end
