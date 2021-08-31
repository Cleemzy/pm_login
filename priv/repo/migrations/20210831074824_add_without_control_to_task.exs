defmodule PmLogin.Repo.Migrations.AddWithoutControlToTask do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :without_control, :boolean, default: false
    end
  end
end
