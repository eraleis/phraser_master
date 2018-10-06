defmodule PhraserMaster.EventMatcher do
  require Logger

  def process_event(payload) do
    log_event(payload)

    with :ok <- human_event?(payload),
         true <- match_phraser_question(payload["event"]["text"]) do
      PhraserMaster.Repo.current_week!()
      |> phraser_response(payload["event"]["channel"])
      |> send_message(payload)
    end
  end

  defp log_event(payload) do
    Logger.info("Event received:")
    Logger.info(inspect(payload))
  end

  defp human_event?(payload) do
    case payload["event"]["subtype"] do
      "bot_message" ->
        :error

      _ ->
        :ok
    end
  end

  defp match_phraser_question(text) do
    ~r/.*(lequel|qui|who|il.*y.*a|y.*a.*t.*il|is.*there).*(phraser).*\?.*/i
    |> Regex.match?(text)
  end

  defp phraser_response(week, channel) do
    case week.slack_username do
      nil ->
        text =
          "Le phraser n'a pas encore été choisi, c'est la tribe **#{week.tribe}** qui s'en occupe !"

      username ->
        text = "Le phraser cette semaine est <#{username}>."
    end

    %{
      channel: channel,
      response_type: "in_channel",
      text: text
    }
  end

  defp send_message(message, slack_payload) do
    team = PhraserMaster.Repo.get_by(PhraserMaster.Team, team_id: slack_payload["team_id"])

    res =
      HTTPoison.post!(
        "https://slack.com/api/chat.postMessage",
        Poison.encode!(message),
        [
          {"Content-type", "application/json"},
          {"Authorization", "Bearer #{team.bot_access_token}"}
        ]
      )

    IO.inspect(res)
  end
end
