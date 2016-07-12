defmodule HansAndFranz.SlackServer do
  use GenServer

  ## public api

  def start_link do
    GenServer.start_link(__MODULE__, self, name: __MODULE__)
  end

  def schedule_next_exercise(channel_id, time) do
    Process.send_after(__MODULE__, {:schedule_next_exercise, channel_id}, time)
  end

  def schedule_next_exercise(channel_id, user, time) do
    Process.send_after(__MODULE__, {:schedule_next_exercise, channel_id, user}, time)
  end

  # GenServer callbacks

  def init(pid) do
    {:ok, slack_pid} = HansAndFranz.Slack.start_link(Application.get_env(:hans_and_franz, :slack_token))
    {:ok, %{slack_pid: slack_pid, pid: pid}}
  end

  def handle_info({:schedule_next_exercise, channel_id, user_id}, %{slack_pid: slack_pid} = state) do
    send(slack_pid, {:next_exercise, channel_id, user_id})
    {:noreply, state}
  end

  def handle_info({:schedule_next_exercise, channel_id}, %{slack_pid: slack_pid} = state) do
    send(slack_pid, {:next_exercise, channel_id})
    {:noreply, state}
  end
end
