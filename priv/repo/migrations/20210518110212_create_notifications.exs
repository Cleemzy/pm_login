defmodule PmLogin.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :content, :string
      add :seen, :boolean, default: false, null: false
      add :sender_id, references(:users, on_delete: :nothing)
      add :receiver_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:notifications, [:sender_id])
    create index(:notifications, [:receiver_id])
  end
end
