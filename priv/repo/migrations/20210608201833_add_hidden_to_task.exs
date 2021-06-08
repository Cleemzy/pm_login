defmodule PmLogin.Repo.Migrations.AddHiddenToTask do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :hidden, :boolean, default: false
    end
  end
end
