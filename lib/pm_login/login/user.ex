defmodule PmLogin.Login.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmLogin.Login.User
  alias PmLogin.Login
  alias Plug.Upload
  alias PmLoginWeb.Router.Helpers, as: Routes

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
  def get_right!(right_id) do
    Login.get_right!(right_id)
  end

  def authenticate(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required(:username, message: "Nom d'utilisateur ne doit pas être vide")
    |> validate_required(:password, message: "Mot de passe ne peut pas être vide")
    |> check_if_user
    |> check_password
    |> apply_action(:login)
  end

  defp check_if_user(changeset) do
    username = get_field(changeset, :username)
    list = Login.list_users
    usernames = Enum.map(list, fn %User{} = user -> user.username end )
    is_user = Enum.member?(usernames, username)
    if username != nil do
        case is_user do
          false -> add_error(changeset, :not_user, "Ce nom d'utlisateur n'existe pas")
          _ -> changeset
        end
      else
        changeset
    end


  end

  defp check_password(changeset) do
    user_name = get_field(changeset, :username)
    pwd = get_field(changeset, :password)
    list = Login.list_users
    user = Enum.find(list, fn %User{} = u -> u.username === user_name end )

      if user != nil and pwd != nil do
        str_pwd = to_string(pwd)
        checked = Bcrypt.verify_pass(str_pwd, user.password)
          case checked do
            false -> add_error(changeset, :wrong_pass, "Mot de passe incorrect")
            _ -> changeset
          end
        else
          changeset
      end

    end



  def profile_changeset(user, attrs, conn) do
    user
    |> cast(attrs, [:username, :email])
    |> unique_constraint(:username, message: "Nom d'utilisateur déjà pris")
    |> validate_format(:email, ~r/@/, message: "Format d'email non valide, ajoutez '@' par exemple ")
    |> unique_constraint(:email, message: "Adresse email déjà pris")
    # |> upload_profile_pic(attrs, conn)
  end

  def upload_profile_pic(changeset, attrs, conn) do
      upload = Map.get(attrs, "photo")
      case upload do
        nil -> changeset

        _ ->
        extension = Path.extname(upload.filename)
        username = get_field(changeset, :username)
        # File.cp(upload.path, "/media/#{user.id}-profile#{extension}")
        profile_pic_path = "images/#{username}-profile#{extension}"
        # File.cp(upload.path, Routes.static_path(conn, "/#{profile_pic_path}"))
        File.cp(upload.path, "/home/matthieu/Pictures")

        put_change(changeset, :profile_picture, profile_pic_path)
      end
  end

  def right_changeset(user, attrs) do
    user
    |> cast(attrs, [:right_id])
  end

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
    |> put_default_right
    |> put_default_profile_picture
  end

  defp apply_log_action(changeset) do
    apply_action(changeset, :login)
  end

  defp validate_changeset(changeset) do
      is_valid = changeset.valid?
      case is_valid do
        true -> {:ok, changeset.changes}
        false -> {:error, changeset}
      end
  end

  defp put_default_right(changeset) do
      put_change(changeset, :right_id, 4)
  end

  defp put_default_profile_picture(changeset) do
      put_change(changeset, :profile_picture, "images/default_profile_pic.png")
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

#   no case clause matching: #Ecto.Changeset<action: nil, changes: %{}, errors: [req_pass_error: {"Mot de passe ne peut pas être vide", []}, req_uname_error: {"Nom d'utilisateur ne doit pas être vide", []}], data: #PmLogin.Login.User<>, valid?: false>
#   no case clause matching: #Ecto.Changeset<action: nil, changes: %{password: "sfdsfdsf", username: "sdfsdf"}, errors: [], data: #PmLogin.Login.User<>, valid?: true>
