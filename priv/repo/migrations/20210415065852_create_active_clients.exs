defmodule PmLogin.Repo.Migrations.CreateActiveClients do
  use Ecto.Migration

  def change do
    create table(:active_clients) do
      add :user_id, references(:users, on_delete: :nothing)
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:active_clients, [:user_id])
    create index(:active_clients, [:company_id])
  end
end
