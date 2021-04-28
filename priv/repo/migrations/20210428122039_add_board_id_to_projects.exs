defmodule PmLogin.Repo.Migrations.AddBoardIdToProjects do
  use Ecto.Migration

  def change do
    alter table("projects") do
      add :board_id, references("boards")
    end
  end
end
