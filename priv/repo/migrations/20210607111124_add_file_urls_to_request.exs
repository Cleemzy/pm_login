defmodule PmLogin.Repo.Migrations.AddFileUrlsToRequest do
  use Ecto.Migration

  def change do
    alter table("clients_requests") do
      add :file_urls, {:array, :string}, null: false, default: []
    end
  end
end
