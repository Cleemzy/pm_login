defmodule PmLogin.Repo.Migrations.CreateRights do
  use Ecto.Migration

  def change do
    create table(:rights) do
      add :title, :string

      timestamps()
    end

  end
end
