defmodule HansAndFranz.Slack do
  use Slack
  alias HansAndFranz.SlackUtils
  alias HansAndFranz.Exercise
  alias HansAndFranz.SlackServer

  @connect_message_wait 1000 * 60       # one minute
  @next_message_wait    1000 * 60 * 30  # 30 minutes

  # slack callbacks

  def handle_connect(slack) do
    connect_exercise(slack)
  end

  # slack handle_message callbacks

  def handle_message(message = %{type: "message", text: text}, slack) do
    cond do
      Regex.match?(~r/<@#{slack.me.id}>/, text) ->
        handle_hans_and_franz_message(message, text, slack)
      true -> true
    end
  end

  def handle_message(_message, _slack) do
    {:ok}
  end

  # slack handle_info callbacks

  def handle_info({:message, text, channel}, slack) do
    send_message(text, channel, slack)
    {:ok}
  end

  def handle_info({:next_exercise, channel_id}, slack) do
    if SlackUtils.is_in_office_hours do
      exercise = Exercise.random
      case SlackUtils.random_user_in_channel(channel_id, slack) do
        {user_id, _user_info} ->
          next_exercise_message(exercise, channel_id, user_id, slack)
        _ -> true
      end
    end

    next_exercise_call(channel_id)
    {:ok}
  end

  def handle_info({:next_exercise, channel_id, user_id}, slack) do
    exercise = Exercise.random
    next_exercise_message(exercise, channel_id, user_id, slack)
    next_exercise_call(channel_id)
    {:ok}
  end

  def handle_info(_, _slack) do
    {:ok}
  end

  # internal calls
  defp connect_exercise(slack) do
    slack.channels
    |> Enum.filter(
        fn {_channel_id, channel_info} ->
          channel_info.is_member && !channel_info.is_archived
        end
      )
    |> Enum.each(&schedule_connect_exercise/1)
  end

  defp schedule_connect_exercise({channel_id, _channel_info}) do
    SlackServer.schedule_next_exercise(channel_id, @connect_message_wait)
  end

  defp next_exercise_call(channel_id) do
    SlackServer.schedule_next_exercise(channel_id, @next_message_wait)
  end

  defp next_exercise_message(exercise, channel_id, user_id, slack) do
    send_message(
      "<@#{user_id}> Give me #{exercise.count} #{exercise.description}!",
      channel_id,
      slack
    )
  end

  defp handle_hans_and_franz_message(message, text, slack) do
    cond do
      Regex.match?(~r/hello/i, text) ->
        handle_hello_message(message.channel, slack)
      Regex.match?(~r/help/i, text) ->
        handle_help_message(message.channel, slack)
      Regex.match?(~r/hit me/i, text) ->
        Apex.ap message.user
        SlackServer.schedule_next_exercise(
          message.channel,
          message.user,
          100
        )
      Regex.match?(~r/stats/i, text) ->
        handle_stats_message(message.channel, message.user, slack)
      Regex.match?(~r/done/i, text) ->
        handle_done_message(message.channel, message.user, slack)
      true -> true
    end
  end

  defp handle_hello_message(channel, slack) do
    send_message(
      Enum.random([
        "I am Hans...Und I am Franz...Und we just vant to pump...YOU UP!",
        "Ya. Ya, girly-man. Hear me now and believe me later.",
        "Welcome to the Pumpatorium!",
        "No flabby losers here!",
        "A little bit about ourselves: We come to the States from a small village of veightlifters in Austria.",
        "Okay, enough talk. Now is the time to go for the pump. Hans, will show you the proper way to lift the veight."
      ]),
      channel,
      slack
    )
  end

  defp handle_help_message(channel, slack) do
    send_message("""
      'hello' - Get a welcome message
      'help' - This message
      'hit me' - Random exercise
      'stats' - Your statistics
      """,
      channel,
      slack
    )
  end

  defp handle_stats_message(channel, user, slack) do
    send_message(
      "stats for #{user}",
      channel,
      slack
    )
  end

  defp handle_done_message(channel, user, slack) do
    send_message(
      "Good job! <@#{user}>",
      channel,
      slack
    )
  end
end

# slack
# me - The current bot/users information stored as a map of properties.
# team - The current team’s information stored as a map of properties.
# bots - Stored as a map with id’s as keys.
# channels - Stored as a map with id’s as keys.
# groups - Stored as a map with id’s as keys.
# users - Stored as a map with id’s as keys.
# ims (direct message channels) - Stored as a map with id’s as keys.
# socket - The connection to Slack.
# client - The client that makes calls to Slack.
