defmodule PmLogin.Repo.Migrations.CreateAuthView do
  use Ecto.Migration

  def up do
     execute """
     CREATE VIEW auth AS
       SELECT users.id, users.username, users.profile_picture, users.email, users.right_id, rights.title
       FROM users
       INNER JOIN rights
       ON users.right_id = rights.id;
     """
   end

   def down do
     execute "DROP VIEW authorization;"
   end
end
