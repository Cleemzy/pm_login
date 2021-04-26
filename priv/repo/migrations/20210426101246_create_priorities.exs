defmodule PmLogin.Repo.Migrations.CreatePriorities do
  use Ecto.Migration

  def change do
    create table(:priorities) do
      add :title, :string

      timestamps()
    end

  end
end
