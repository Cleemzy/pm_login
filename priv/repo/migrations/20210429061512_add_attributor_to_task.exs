defmodule PmLogin.Repo.Migrations.AddAttributorToTask do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :attributor_id, references("users")
    end
  end
end
