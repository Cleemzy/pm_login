defmodule PmLogin.Repo.Migrations.CreateAssistContracts do
  use Ecto.Migration

  def change do
    create table(:assist_contracts) do
      add :title, :string
      add :date_start, :date
      add :date_end, :date
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:assist_contracts, [:company_id])
  end
end
