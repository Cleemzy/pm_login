defmodule PmLoginWeb.EditorController do
  use PmLoginWeb, :controller

  # alias PmLogin.Services
  # alias PmLogin.Services.Editor

  # def index(conn, _params) do
  #   editors = Services.list_editors()
  #   render(conn, "index.html", editors: editors)
  # end

  # def new(conn, _params) do
  #   changeset = Services.change_editor(%Editor{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"editor" => editor_params}) do
  #   case Services.create_editor(editor_params) do
  #     {:ok, editor} ->
  #       conn
  #       |> put_flash(:info, "Editor created successfully.")
  #       |> redirect(to: Routes.editor_path(conn, :show, editor))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   editor = Services.get_editor!(id)
  #   render(conn, "show.html", editor: editor)
  # end

  # def edit(conn, %{"id" => id}) do
  #   editor = Services.get_editor!(id)
  #   changeset = Services.change_editor(editor)
  #   render(conn, "edit.html", editor: editor, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "editor" => editor_params}) do
  #   editor = Services.get_editor!(id)
  #
  #   case Services.update_editor(editor, editor_params) do
  #     {:ok, editor} ->
  #       conn
  #       |> put_flash(:info, "Editor updated successfully.")
  #       |> redirect(to: Routes.editor_path(conn, :show, editor))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", editor: editor, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   editor = Services.get_editor!(id)
  #   {:ok, _editor} = Services.delete_editor(editor)
  #
  #   conn
  #   |> put_flash(:info, "Editor deleted successfully.")
  #   |> redirect(to: Routes.editor_path(conn, :index))
  # end
  
end
