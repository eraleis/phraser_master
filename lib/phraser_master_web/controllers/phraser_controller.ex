defmodule PhraserMasterWeb.PhraserController do
  use PhraserMasterWeb, :controller

  def show(conn, params) do
    team = PhraserMaster.Repo.get_by(PhraserMaster.Team, team_id: params["team_id"])

    response =
      PhraserMaster.Repo.current_week!(team)
      |> phraser_response()

    json(conn, response)
  end

  def create(conn, params) do
    team = PhraserMaster.Repo.get_by(PhraserMaster.Team, team_id: params["team_id"])

    response =
      params["text"]
      |> set_weekly_phraser(team)
      |> setphraser_response()

    json(conn, response)
  end

  defp set_weekly_phraser("", team),
    do: {:error, "You must specify a slack username.\nex: `/setphraser @slack_username`"}

  defp set_weekly_phraser(username, team) do
    changeset =
      PhraserMaster.Repo.current_week!(team)
      |> PhraserMaster.Week.slack_username_changeset(%{slack_username: username})
      |> PhraserMaster.Repo.update()
  end

  defp setphraser_response({:error, message}) do
    %{
      attachments: [
        %{
          color: "#D32F2F",
          text: message
        }
      ]
    }
  end

  defp setphraser_response({:ok, week}) do
    %{
      attachments: [
        %{
          color: "#2eb886",
          text: "You just set <#{week.slack_username}> as the phraser this week."
        }
      ]
    }
  end

  defp phraser_response(week) do
    case week.slack_username do
      nil ->
        slack_username_color = "#D32F2F"
        slack_username_text = "No phraser has been chosen yet."

      username ->
        slack_username_color = "#00796B"
        slack_username_text = "The phraser this week is <#{username}>."
    end

    %{
      response_type: "in_channel",
      attachments: [
        %{
          color: "#2eb886",
          text: "The tribe providing a phraser this week is *#{week.tribe}*."
        },
        %{
          color: slack_username_color,
          text: slack_username_text
        }
      ]
    }
  end
end
