defmodule PmLogin.Monitoring.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmLogin.Monitoring
  alias PmLogin.Kanban
  alias PmLogin.Kanban.Card
  alias PmLogin.Login.User
  alias PmLogin.Monitoring.{Status,Priorty}


  schema "tasks" do
    field :date_end, :date
    field :date_start, :date
    field :deadline, :date
    field :estimated_duration, :integer
    field :performed_duration, :integer
    field :progression, :integer
    field :title, :string
    field :parent_id, :id
    field :project_id, :id
    field :contributor_id, :id
    # field :status_id, :id
    # field :priority_id, :id
    # field :attributor_id, :id
    belongs_to :priority, Priority
    belongs_to :attributor, User
    belongs_to :status, Status
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :attributor_id, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline])
    |> validate_required([:title, :progression, :date_start, :date_end, :estimated_duration, :performed_duration, :deadline])
  end

  def update_changeset(task, attrs) do
    task
    |> cast(attrs, [:progression, :date_start, :date_end, :estimated_duration, :performed_duration])
    |> Monitoring.validate_dates_without_deadline
    |> Monitoring.validate_start_end
    |> Monitoring.validate_positive_estimated
    |> Monitoring.validate_positive_performed
    |> Monitoring.validate_progression
  end

  def create_changeset(task, attrs) do
    # %{"project_id" => pro_id, "title" => title} = attrs
    #
    #   project = Monitoring.get_project!(pro_id)
    #   board = Kanban.get_board!(project.board_id)
    #   stage = Kanban.get_stage_by_position!(board.id,0)
    #
    # case Kanban.create_card(%{name: title, stage_id: stage.id}) do
    #   {:ok, card} ->
        task
        |> cast(attrs, [:title, :attributor_id, :project_id,:date_start, :date_end, :estimated_duration, :deadline])
        |> validate_required(:title, message: "Entrez tâche")
        |> unique_constraint(:title, message: "Tâche déjà existante")
        |> validate_required(:estimated_duration, message: "Entrez estimation")
        |> validate_required(:date_start, message: "Entrez date de début")
        |> validate_required(:date_end, message: "Entrez date de fin")
        |> validate_required(:deadline, message: "Entrez date d'échéance")
        |> Monitoring.validate_dates
        |> Monitoring.validate_start_end
        |> Monitoring.validate_start_deadline
        |> Monitoring.validate_positive_estimated
        |> put_change(:progression, 0)
        # |> put_change(:status_id, stage.status_id)
        # |> put_change(:project_id, pro_id)
        |> put_change(:performed_duration, 0)
        |> put_change(:priority_id, 2)
        |> put_change(:status_id, 1)


        # {:error, %Ecto.Changeset{} = changeset} ->
        # task
        # |> cast(attrs, [:title, :date_start, :date_end, :estimated_duration, :deadline])
        # |> validate_required(:title, message: "Entrez tâche")
        # |> unique_constraint(:title, message: "Tâche déjà existante")
        # |> validate_required(:estimated_duration, message: "Entrez estimation")
        # |> validate_required(:date_start, message: "Entrez date de début")
        # |> validate_required(:date_end, message: "Entrez date de fin")
        # |> validate_required(:deadline, message: "Entrez date d'échéance")
        # |> Monitoring.validate_dates
        # |> Monitoring.validate_start_end
        # |> Monitoring.validate_start_deadline
        # |> Monitoring.validate_positive_estimated
        # |> put_change(:progression, 0)
        # # |> put_change(:card_id, card.id)
        # |> put_change(:status_id, stage.status_id)
        # |> put_change(:project_id, project.id)
        # |> put_change(:performed_duration, 0)
        # |> put_change(:priority_id, 2)
        # |> put_change(:status_id, 1)

  end

end
