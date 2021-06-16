defmodule PmLogin.Repo.Migrations.AddFileUrlsToComments do
  use Ecto.Migration

  def change do
    alter table("comments") do
      add :file_urls, {:array, :string}, null: false, default: []
    end
  end
end
