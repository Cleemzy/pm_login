defmodule PmLogin.Repo.Migrations.CreateLicenses do
  use Ecto.Migration

  def change do
    create table(:licenses) do
      add :title, :string
      add :date_start, :date
      add :date_end, :date
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:licenses, [:company_id])
  end
end
