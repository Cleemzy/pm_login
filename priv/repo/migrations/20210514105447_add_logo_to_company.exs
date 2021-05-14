defmodule PmLogin.Repo.Migrations.AddLogoToCompany do
  use Ecto.Migration

  def change do
    alter table("companies") do
      add :logo, :string 
    end
  end
end
