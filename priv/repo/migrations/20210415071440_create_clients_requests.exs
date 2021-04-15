defmodule PmLogin.Repo.Migrations.CreateClientsRequests do
  use Ecto.Migration

  def change do
    create table(:clients_requests) do
      add :content, :string
      add :date_post, :naive_datetime
      add :active_client_id, references(:active_clients, on_delete: :nothing)
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:clients_requests, [:active_client_id])
    create index(:clients_requests, [:company_id])
  end
end
