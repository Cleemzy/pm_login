defmodule PmLogin.Repo.Migrations.ChangeClientsRequests do
  use Ecto.Migration

  def change do

    alter table("clients_requests") do
      remove :company_id
      add :seen, :boolean
      add :ongoing, :boolean
      add :done, :boolean
    end

  end
end
