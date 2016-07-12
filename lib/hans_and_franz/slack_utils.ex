defmodule HansAndFranz.SlackUtils do
  require IEx

  @doc """
  find the slack channels slack.me is in
  """
  def channels_im_in(slack) do
    slack.channels
    |> Enum.filter(
        fn {_channel_id, channel_info} ->
          channel_info.is_member && !channel_info.is_archived
        end
      )
  end

  @doc """
  lookup the user from the list of slack users
  """
  def lookup_user(user_id, slack) do
    slack.users
    |> Enum.find(fn {id, _user} -> user_id == id end)
  end

  @doc """
  Find me a random active user in the channel that isn't me
  """
  def random_user_in_channel(channel_id, slack) do
    {_channel_id, channel} = slack.channels
      |> Enum.find(fn {c_id, channel} -> c_id == channel_id end)

    if channel do
      channel.members
      |> Enum.map(fn user_id -> HansAndFranz.SlackUtils.lookup_user(user_id, slack) end)
      |> Enum.filter(fn item -> item end)
      |> Enum.filter(fn {_user_id, user} ->
          user.presence == "active" && user.id != slack.me.id
        end)
      |> random
    else
      nil
    end
  end

  defp random(nil), do: nil
  defp random([]), do: nil
  defp random(list), do: Enum.random(list)
end
