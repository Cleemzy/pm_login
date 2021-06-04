defmodule PmLogin.Services.ClientsRequest do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmLogin.Services.ActiveClient
  schema "clients_requests" do
    field :title, :string
    field :content, :string
    field :date_post, :naive_datetime
    field :seen, :boolean
    field :ongoing, :boolean
    field :done, :boolean
    # field :active_client_id, :id
    belongs_to :active_client, ActiveClient

    timestamps()
  end

  @doc false
  def changeset(clients_request, attrs) do
    clients_request
    |> cast(attrs, [:title ,:content, :date_post, :seen, :ongoing, :done])
    # |> unique_constraint(:title, message: "Titre de requête déjà existant")
    # |> validate_required(:content, message: "Entrez le contenu de votre requête")
  end

  def create_changeset(clients_request, attrs) do
    clients_request
    |> cast(attrs, [:title ,:content, :date_post, :seen, :ongoing, :done])
    |> validate_required(:title, message: "Entrez l'intitulé de votre requête.")
    |> unique_constraint(:title, message: "Titre de requête déjà existant.")
    |> validate_required(:content, message: "Entrez le contenu de votre requête.")
    |> put_change(:date_post, NaiveDateTime.local_now)
  end
end
