defmodule PmLogin.MyContex do
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias PmLogin.Repo
  alias PmLogin.Monitoring

  def todays_dataset do
    todays = Monitoring.list_achieved_tasks_today

    data = Enum.map(todays, fn(task) -> %{category_col: task.priority_id,
          task_col: task.title, start_col: date_to_datetime(task.date_start), finish_col: naive_to_datetime(task.achieved_at)} end)
    dataset = Contex.Dataset.new(data)

    list = Enum.map(todays, fn(task) -> [task.priority_id, task.title, date_to_datetime(task.date_start), naive_to_datetime(task.achieved_at)] end)

    list_dataset = Contex.Dataset.new(list)
    IO.inspect list_dataset
    # plot_content = Contex.GanttChart.new(dataset, mapping: %{category_col: :category_col, task_col: :task_col, start_col: :start_col, finish_col: :finish_col} )
    plot_content = Contex.GanttChart.new(list_dataset)


    plot = Contex.Plot.new(1200, 200, plot_content)
    output = Contex.Plot.to_svg(plot)
  end

  def this_week_dataset do
    todays = Monitoring.list_achieved_tasks_this_week

    data = Enum.map(todays, fn(task) -> %{category_col: task.priority_id,
          task_col: task.title, start_col: date_to_datetime(task.date_start), finish_col: naive_to_datetime(task.achieved_at)} end)
    dataset = Contex.Dataset.new(data)

    list = Enum.map(todays, fn(task) -> [task.priority_id, task.title, date_to_datetime(task.date_start), naive_to_datetime(task.achieved_at)] end)

    list_dataset = Contex.Dataset.new(list)
    IO.inspect list_dataset
    # plot_content = Contex.GanttChart.new(dataset, mapping: %{category_col: :category_col, task_col: :task_col, start_col: :start_col, finish_col: :finish_col} )
    plot_content = Contex.GanttChart.new(list_dataset)


    plot = Contex.Plot.new(1200, 600, plot_content)
    output = Contex.Plot.to_svg(plot)
  end

  def this_month_dataset do
    todays = Monitoring.list_achieved_tasks_this_month

    data = Enum.map(todays, fn(task) -> %{category_col: task.priority_id,
          task_col: task.title, start_col: date_to_datetime(task.date_start), finish_col: naive_to_datetime(task.achieved_at)} end)
    dataset = Contex.Dataset.new(data)

    list = Enum.map(todays, fn(task) -> [task.priority_id, task.title, date_to_datetime(task.date_start), naive_to_datetime(task.achieved_at)] end)

    list_dataset = Contex.Dataset.new(list)
    IO.inspect list_dataset
    # plot_content = Contex.GanttChart.new(dataset, mapping: %{category_col: :category_col, task_col: :task_col, start_col: :start_col, finish_col: :finish_col} )
    plot_content = Contex.GanttChart.new(list_dataset)


    plot = Contex.Plot.new(1200, 800, plot_content)
    output = Contex.Plot.to_svg(plot)
  end

  def naive_to_datetime(naive) do
    {:ok, datetime} = DateTime.from_naive(naive, "Etc/UTC")
    datetime
  end

  def date_to_datetime(date) do
    {:ok, naive} = {Date.to_erl(date),{0,0,0}} |> NaiveDateTime.from_erl
    naive_to_datetime(naive)
  end

end
