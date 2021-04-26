defmodule PmLogin.MonitoringTest do
  use PmLogin.DataCase

  alias PmLogin.Monitoring

  describe "statuses" do
    alias PmLogin.Monitoring.Status

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def status_fixture(attrs \\ %{}) do
      {:ok, status} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Monitoring.create_status()

      status
    end

    test "list_statuses/0 returns all statuses" do
      status = status_fixture()
      assert Monitoring.list_statuses() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Monitoring.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      assert {:ok, %Status{} = status} = Monitoring.create_status(@valid_attrs)
      assert status.title == "some title"
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitoring.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      assert {:ok, %Status{} = status} = Monitoring.update_status(status, @update_attrs)
      assert status.title == "some updated title"
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitoring.update_status(status, @invalid_attrs)
      assert status == Monitoring.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Monitoring.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Monitoring.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Monitoring.change_status(status)
    end
  end

  describe "projects" do
    alias PmLogin.Monitoring.Project

    @valid_attrs %{date_end: ~D[2010-04-17], date_start: ~D[2010-04-17], deadline: ~D[2010-04-17], description: "some description", estimated_duration: 42, performed_duration: 42, progression: 42, title: "some title"}
    @update_attrs %{date_end: ~D[2011-05-18], date_start: ~D[2011-05-18], deadline: ~D[2011-05-18], description: "some updated description", estimated_duration: 43, performed_duration: 43, progression: 43, title: "some updated title"}
    @invalid_attrs %{date_end: nil, date_start: nil, deadline: nil, description: nil, estimated_duration: nil, performed_duration: nil, progression: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Monitoring.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Monitoring.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Monitoring.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Monitoring.create_project(@valid_attrs)
      assert project.date_end == ~D[2010-04-17]
      assert project.date_start == ~D[2010-04-17]
      assert project.deadline == ~D[2010-04-17]
      assert project.description == "some description"
      assert project.estimated_duration == 42
      assert project.performed_duration == 42
      assert project.progression == 42
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitoring.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Monitoring.update_project(project, @update_attrs)
      assert project.date_end == ~D[2011-05-18]
      assert project.date_start == ~D[2011-05-18]
      assert project.deadline == ~D[2011-05-18]
      assert project.description == "some updated description"
      assert project.estimated_duration == 43
      assert project.performed_duration == 43
      assert project.progression == 43
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitoring.update_project(project, @invalid_attrs)
      assert project == Monitoring.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Monitoring.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Monitoring.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Monitoring.change_project(project)
    end
  end

  describe "priorities" do
    alias PmLogin.Monitoring.Priority

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def priority_fixture(attrs \\ %{}) do
      {:ok, priority} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Monitoring.create_priority()

      priority
    end

    test "list_priorities/0 returns all priorities" do
      priority = priority_fixture()
      assert Monitoring.list_priorities() == [priority]
    end

    test "get_priority!/1 returns the priority with given id" do
      priority = priority_fixture()
      assert Monitoring.get_priority!(priority.id) == priority
    end

    test "create_priority/1 with valid data creates a priority" do
      assert {:ok, %Priority{} = priority} = Monitoring.create_priority(@valid_attrs)
      assert priority.title == "some title"
    end

    test "create_priority/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitoring.create_priority(@invalid_attrs)
    end

    test "update_priority/2 with valid data updates the priority" do
      priority = priority_fixture()
      assert {:ok, %Priority{} = priority} = Monitoring.update_priority(priority, @update_attrs)
      assert priority.title == "some updated title"
    end

    test "update_priority/2 with invalid data returns error changeset" do
      priority = priority_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitoring.update_priority(priority, @invalid_attrs)
      assert priority == Monitoring.get_priority!(priority.id)
    end

    test "delete_priority/1 deletes the priority" do
      priority = priority_fixture()
      assert {:ok, %Priority{}} = Monitoring.delete_priority(priority)
      assert_raise Ecto.NoResultsError, fn -> Monitoring.get_priority!(priority.id) end
    end

    test "change_priority/1 returns a priority changeset" do
      priority = priority_fixture()
      assert %Ecto.Changeset{} = Monitoring.change_priority(priority)
    end
  end

  describe "tasks" do
    alias PmLogin.Monitoring.Task

    @valid_attrs %{date_end: ~D[2010-04-17], date_start: ~D[2010-04-17], deadline: ~D[2010-04-17], estimated_duration: 42, performed_duration: 42, progression: 42, title: "some title"}
    @update_attrs %{date_end: ~D[2011-05-18], date_start: ~D[2011-05-18], deadline: ~D[2011-05-18], estimated_duration: 43, performed_duration: 43, progression: 43, title: "some updated title"}
    @invalid_attrs %{date_end: nil, date_start: nil, deadline: nil, estimated_duration: nil, performed_duration: nil, progression: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Monitoring.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Monitoring.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Monitoring.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Monitoring.create_task(@valid_attrs)
      assert task.date_end == ~D[2010-04-17]
      assert task.date_start == ~D[2010-04-17]
      assert task.deadline == ~D[2010-04-17]
      assert task.estimated_duration == 42
      assert task.performed_duration == 42
      assert task.progression == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitoring.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Monitoring.update_task(task, @update_attrs)
      assert task.date_end == ~D[2011-05-18]
      assert task.date_start == ~D[2011-05-18]
      assert task.deadline == ~D[2011-05-18]
      assert task.estimated_duration == 43
      assert task.performed_duration == 43
      assert task.progression == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitoring.update_task(task, @invalid_attrs)
      assert task == Monitoring.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Monitoring.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Monitoring.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Monitoring.change_task(task)
    end
  end

  describe "comments" do
    alias PmLogin.Monitoring.Comment

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Monitoring.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Monitoring.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Monitoring.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Monitoring.create_comment(@valid_attrs)
      assert comment.content == "some content"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitoring.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Monitoring.update_comment(comment, @update_attrs)
      assert comment.content == "some updated content"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitoring.update_comment(comment, @invalid_attrs)
      assert comment == Monitoring.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Monitoring.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Monitoring.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Monitoring.change_comment(comment)
    end
  end
end
