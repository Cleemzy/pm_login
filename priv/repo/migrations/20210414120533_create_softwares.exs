defmodule PmLogin.Repo.Migrations.CreateSoftwares do
  use Ecto.Migration

  def change do
    create table(:softwares) do
      add :title, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:softwares, [:company_id])
  end
end
