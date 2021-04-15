defmodule PmLogin.Services.ClientsRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients_requests" do
    field :content, :string
    field :date_post, :naive_datetime
    field :active_client_id, :id
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(clients_request, attrs) do
    clients_request
    |> cast(attrs, [:content, :date_post])
    |> validate_required([:content, :date_post])
  end
end
