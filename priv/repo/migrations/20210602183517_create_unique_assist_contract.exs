defmodule PmLogin.Repo.Migrations.CreateUniqueAssistContract do
  use Ecto.Migration

  def change do
    create unique_index(:assist_contracts, [:title])
  end
end
