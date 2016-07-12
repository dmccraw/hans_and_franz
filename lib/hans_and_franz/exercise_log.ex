defmodule HansAndFranz.ExerciseLog do
  use GenServer

  ## public api

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end
end
