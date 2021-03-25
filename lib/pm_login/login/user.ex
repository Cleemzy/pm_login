defmodule PmLogin.Login.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :profile_picture, :string
    field :username, :string
    field :right_id, :id

    timestamps()
  end


  # def changeset(user, attrs) do
  #   user
  #   |> cast(attrs, [:username, :email, :password])
  #   |> validate_required([:username, :email, :password])
  #   |> unique_constraint(:username)
  #   |> unique_constraint(:email)
  # end
  #
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required_username
    |> validate_required_password
    |> validate_required_email
    |> unique_constraint(:username, message: "Nom d'utilisateur déjà pris")
    |> validate_format(:email, ~r/@/, message: "Format d'email non valide, ajoutez '@' par exemple ")
    |> unique_constraint(:email, message: "Adresse e-mail déjà utilisé")
    |> validate_confirmation(:email, message: "Ne correspond pas à l'adresse mail donnée")
    |> validate_confirmation(:password, message: "Les mots de passe ne correspondent pas")
    |> crypt_pass
  end

  defp crypt_pass(changeset) do
    pass_field = get_field(changeset, :password)
    cry = to_string(pass_field)
    encrypted = Bcrypt.hash_pwd_salt(cry)
    put_change(changeset, :password, encrypted)
  end

  defp validate_required_username(changeset) do
    username = get_field(changeset, :username)
    case username do
      nil -> add_error(changeset, :req_uname_error, "Nom d'utilisateur ne doit pas être vide")
      _ -> changeset
    end
  end

  defp validate_required_email(changeset) do
    email = get_field(changeset, :email)
    case email do
      nil -> add_error(changeset, :req_email_error, "L'adresse e-mail ne peut pas être vide")
      _ -> changeset
    end
  end

  defp validate_required_password(changeset) do
    password = get_field(changeset, :password)
    case password do
      nil -> add_error(changeset, :req_pass_error, "Mot de passe ne peut pas être vide")
      _ -> changeset
    end
  end

end
