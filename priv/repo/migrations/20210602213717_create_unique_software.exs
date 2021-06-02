defmodule PmLogin.Repo.Migrations.CreateUniqueSoftware do
  use Ecto.Migration

  def change do
    create unique_index(:softwares, [:title])
  end
end
