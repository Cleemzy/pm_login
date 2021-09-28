defmodule PmLogin.TaskSpawner do
  use GenServer

  def start_link(opts) do
    # IO.inspect opts
    GenServer.start_link(__MODULE__, opts)
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    recurrent_work(state)
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    # In 2 hours
    # Process.send_after(self(), :work, 2 * 60 * 60 * 1000)
    Process.send_after(self(), :work,  5 * 1000)
  end

  defp recurrent_work(state) do
    IO.puts("working.. "<>Map.get(state, :name))
  end

end
