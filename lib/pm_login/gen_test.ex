defmodule PmLogin.GenTest do
  use GenServer

  def start_link(opts) do
    IO.inspect opts
    GenServer.start_link(__MODULE__, opts)
  end

  def init(state) do
    # IO.inspect(state)
    # IO.puts("salama ty gen ty")
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here

    {:noreply, state}
  end

  # defp schedule_work() do
  #   Process.send_after(self(), :work, 2 * 60 * 60 * 1000) # In 2 hours
  # end

end
