defmodule PmLogin.Repo.Migrations.CreateEditors do
  use Ecto.Migration

  def change do
    create table(:editors) do
      add :title, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:editors, [:company_id])
  end
end
