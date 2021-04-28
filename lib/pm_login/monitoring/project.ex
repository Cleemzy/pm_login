defmodule PmLogin.Monitoring.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmLogin.Monitoring
  alias PmLogin.Monitoring.Task
  alias PmLogin.Kanban

  schema "projects" do
    field :date_end, :date
    field :date_start, :date
    field :deadline, :date
    field :description, :string
    field :estimated_duration, :integer
    field :performed_duration, :integer
    field :progression, :integer
    field :title, :string
    field :active_client_id, :id
    field :status_id, :id
    field :board_id, :id
    has_many :tasks, Task

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :description, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline, :active_client_id, :status_id])
    |> validate_required([:title, :description, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline, :active_client_id, :status_id])
  end

  def create_changeset(project, attrs) do
    %{"title" => project_title} = attrs

    case Kanban.create_board(%{name: project_title}) do
      {:ok, board} ->
        for status <- Monitoring.list_statuses do
          Kanban.create_stage_from_project(%{name: status.title, board_id: board.id, status_id: status.id})
        end
        project
        |> cast(attrs, [:title, :description,:date_start, :date_end, :estimated_duration, :deadline, :active_client_id])
        |> foreign_key_constraint(:active_client_id)
        |> unique_constraint(:title, message: "Ce nom de projet existe déjà")
        |> validate_required(:estimated_duration, message: "Entrez la durée estimée du projet")
        |> validate_required(:title, message: "Veuillez entrer le nom de votre projet")
        |> validate_required(:description, message: "Aucune description donnée")
        |> validate_required(:date_start, message: "Entrez une date de début")
        |> validate_required(:date_end, message: "Entrez une date de fin")
        |> validate_required(:estimated_duration, message: "Entrez une estimation en heure")
        |> validate_required(:deadline, message: "Entrez la date d'échéance")
        |> validate_dates
        |> validate_start_end
        |> validate_start_deadline
        |> validate_positive_estimated
        |> put_default_progression
        |> put_change(:board_id, board.id)
        |> put_change(:performed_duration, 0)
        |> put_change(:status_id, 1)


      {:error, %Ecto.Changeset{} = _changeset} ->
        project
        |> cast(attrs, [:title, :description,:date_start, :date_end, :estimated_duration, :deadline, :active_client_id])
        |> foreign_key_constraint(:active_client_id)
        |> unique_constraint(:title, message: "Ce nom de projet existe déjà")
        |> validate_required(:estimated_duration, message: "Entrez la durée estimée du projet")
        |> validate_required(:title, message: "Veuillez entrer le nom de votre projet")
        |> validate_required(:description, message: "Aucune description donnée")
        |> validate_required(:date_start, message: "Entrez une date de début")
        |> validate_required(:date_end, message: "Entrez une date de fin")
        |> validate_required(:estimated_duration, message: "Entrez une estimation en heure")
        |> validate_required(:deadline, message: "Entrez la date d'échéance")
        |> validate_dates
        |> validate_start_end
        |> validate_start_deadline
        |> validate_positive_estimated
        |> put_default_progression
        |> put_change(:performed_duration, 0)
        |> put_change(:status_id, 1)
    end

  end

  defp put_default_progression(changeset) do
    changeset |> put_change(:progression, 0)
  end

  defp validate_positive_estimated(changeset) do
    est = get_field(changeset, :estimated_duration)
    case est do
      nil -> changeset
      _ -> cond do
            est < 0 -> changeset |> add_error(:negative_estimated, "La durée estimée ne peut être négative")
            true -> changeset
          end
    end
  end

  defp validate_start_deadline(changeset) do
    date_start = get_field(changeset, :date_start)
    deadline = get_field(changeset, :deadline)

    if date_start != nil and deadline != nil do

      dt_start = date_start |> to_string |> string_to_date
      dt_deadline = deadline |> to_string |> string_to_date

      case Date.compare(dt_deadline, dt_start) do
        :lt ->
          changeset |> add_error(:deadline_before_dtstart, "La date d'échéance ne peut pas être antérieure à la date de début")
        _ -> changeset
      end

    else
      changeset
    end
  end

  defp validate_start_end(changeset) do
    date_start = get_field(changeset, :date_start)
    date_end = get_field(changeset, :date_end)

    if date_start != nil and date_end != nil do

      dt_start = date_start |> to_string |> string_to_date
      dt_end = date_end |> to_string |> string_to_date

      case Date.compare(dt_end, dt_start) do
        :lt ->
          # IO.puts "startEnd"
          changeset |> add_error(:dt_end_lt_start, "La date finale ne peut pas être antérieure à la date de début")
        _ -> changeset
      end

    else
      changeset
    end
  end

  defp validate_dates(changeset) do
    today = Date.utc_today
    date_start = get_field(changeset, :date_start)
    date_end = get_field(changeset, :date_end)
    deadline = get_field(changeset, :deadline)

    # IO.puts(date_start != "" and date_end != "" and deadline != "")
    if date_start != nil and date_end != nil and deadline != nil do

          dt_start = date_start |> to_string |> string_to_date
          dt_end = date_end |> to_string |> string_to_date
          dt_deadline = deadline |> to_string |> string_to_date

          cond do
            Date.compare(dt_start,today) == :lt ->
                changeset
                |> add_error(:date_start_lt, "La date de début ne peut pas être antérieure à aujourd'hui")
            Date.compare(dt_end,today) == :lt ->
                changeset
                |> add_error(:date_end_lt, "La date de fin ne peut pas être antérieure à aujourd'hui")
            Date.compare(dt_deadline,today) == :lt ->
                changeset
                |> add_error(:deadline_lt, "La date d'échéance ne peut pas être antérieure à aujourd'hui")
            true -> changeset
          end
    else
      changeset
    end

  end

  defp string_to_date(str) do
    [str_y, str_m, str_d] = String.split(str,"-")
    [y, m, d] = [String.to_integer(str_y), String.to_integer(str_m), String.to_integer(str_d)]
    {:ok, date} = Date.new(y,m,d)
    date
  end

end
