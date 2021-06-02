defmodule PmLogin.Repo.Migrations.CreateUniqueLicense do
  use Ecto.Migration

  def change do
    create unique_index(:licenses, [:title])
  end
end
