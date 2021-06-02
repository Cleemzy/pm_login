defmodule PmLogin.Repo.Migrations.CreateUniqueEditor do
  use Ecto.Migration

  def change do
    create unique_index(:editors, [:title])
  end
end
