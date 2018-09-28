defmodule PhraserMasterWeb.PhraserController do
  use PhraserMasterWeb, :controller

  def show(conn, _params) do
    response =
      PhraserMaster.Repo.current_week!()
      |> phraser_response()

    json(conn, response)
  end

  defp phraser_response(week) do
    case week.slack_username do
      nil ->
        slack_username_color = "#D32F2F"
        slack_username_text = "No phraser has been chosen yet"

      username ->
        slack_username_color = "#00796B"
        slack_username_text = "The phraser for the week is *#{username}*"
    end

    %{
      response_type: "in_channel",
      attachments: [
        %{
          color: "#2eb886",
          text: "The tribe providing a phraser this week is *#{week.tribe}*"
        },
        %{
          color: slack_username_color,
          text: slack_username_text
        }
      ]
    }
  end
end
