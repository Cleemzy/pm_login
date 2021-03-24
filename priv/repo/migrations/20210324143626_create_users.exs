defmodule PmLogin.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :profile_picture, :string
      add :email, :string
      add :password, :string
      add :right_id, references(:rights, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
    create index(:users, [:right_id])
  end
end
