defmodule PmLogin.Services.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string
    field :logo, :string
    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required(:name, message: "Ne peut pas être vide")
  end

  def create_changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required(:name, message: "Ne peut pas être vide")
    |> upload_logo(attrs)
  end

  defp upload_logo(changeset, attrs) do
    upload = attrs["photo"]
    case upload do
      nil ->
      changeset
      |> put_change(:logo, "images/company_logos/company_default_logo.png")

      _ ->
      extension = Path.extname(upload.filename)
      name = get_field(changeset, :name)
      logo_path = "company_logos/#{name}-logo#{extension}"
      path_in_db = "images/#{logo_path}"
      File.cp(upload.path, "assets/static/images/#{logo_path}")
      IO.puts path_in_db
      changeset |> put_change(:logo, path_in_db )
    end
  end
end
