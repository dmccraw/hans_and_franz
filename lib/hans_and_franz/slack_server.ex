defmodule HansAndFranz.SlackServer do
  use GenServer
  require Logger

  ## public api

  def start_link do
    GenServer.start_link(__MODULE__, self, name: __MODULE__)
  end

  def schedule_next_exercise(channel_id, milliseconds) do
    Logger.debug("slack_server schedule_next_exercise #{inspect channel_id} : #{inspect milliseconds}")
    GenServer.cast(__MODULE__, {:schedule_next_exercise, channel_id, milliseconds})
  end

  def schedule_next_exercise(channel_id, user_id, milliseconds) do
    Logger.debug("slack_server schedule_next_exercise #{inspect channel_id} : #{inspect user_id} : #{inspect milliseconds}")
    GenServer.cast(__MODULE__, {:schedule_next_exercise, channel_id, user_id, milliseconds})
  end

  # GenServer callbacks

  def init(pid) do
    {:ok, slack_pid} = HansAndFranz.Slack.start_link(Application.get_env(:hans_and_franz, :slack_token))
    {:ok, %{slack_pid: slack_pid, pid: pid}}
  end

  def handle_cast({:schedule_next_exercise, channel_id, milliseconds}, state) do
    Logger.debug("slack_server handle_cast schedule_next_exercise #{inspect channel_id} : #{inspect milliseconds}")
    Process.send_after(self(), {:next_exercise, channel_id}, milliseconds)
    {:noreply, state}
  end

  def handle_cast({:schedule_next_exercise, channel_id, user_id, milliseconds}, state) do
    Logger.debug("slack_server handle_cast schedule_next_exercise #{inspect channel_id } : #{inspect user_id} : #{inspect milliseconds}")
    Process.send_after(self(), {:next_exercise, channel_id, user_id}, milliseconds)
    {:noreply, state}
  end

  def handle_info({:next_exercise, channel_id, user_id}, %{slack_pid: slack_pid} = state) do
    Logger.debug("slack_server handle_info next_exercise #{inspect channel_id} : #{inspect user_id}")
    send(slack_pid, {:next_exercise, channel_id, user_id})
    {:noreply, state}
  end

  def handle_info({:next_exercise, channel_id}, %{slack_pid: slack_pid} = state) do
    Logger.debug("slack_server handle_info next_exercise #{inspect channel_id}")
    send(slack_pid, {:next_exercise, channel_id})
    {:noreply, state}
  end
end
