defmodule PmLogin.Repo.Migrations.AddTitleToClientRequest do
  use Ecto.Migration

  def change do
    alter table("clients_requests") do
      add :title, :string
    end

    create unique_index(:clients_requests, [:title])
  end
end
