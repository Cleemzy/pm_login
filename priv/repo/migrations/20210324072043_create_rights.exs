defmodule PmLogin.Repo.Migrations.CreateRights do
  use Ecto.Migration

  def change do
    create table(:rights) do
      add :title, :string

      timestamps()
    end

    create unique_index(:rights, [:title])
  end
end
