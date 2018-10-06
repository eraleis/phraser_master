defmodule PhraserMasterWeb.PageController do
  use PhraserMasterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def redirect(conn, params) do
    response =
      HTTPoison.post!(
        "https://slack.com/api/oauth.access?client_id=444615955152.445166545268&client_secret=cd93a287816c37ddbf7600d0758e4abf&code=#{
          params["code"]
        }&redirect_uri=#{
          PhraserMasterWeb.Router.Helpers.page_url(PhraserMasterWeb.Endpoint, :redirect)
        }",
        "",
        [{"Content-type", "application/x-www-form-urlencoded"}]
      )

    decoded_response = Poison.decode!(response.body)

    case Map.take(decoded_response, ["ok"]) do
      %{"ok" => true} ->
        create_or_update_team(decoded_response)
        text(conn, "Successfuly added to your slack team.")

      _ ->
        text(conn, "Oups, there is an error: #{decoded_response["error"]}")
    end
  end

  defp create_or_update_team(decoded_response) do
    case PhraserMaster.Repo.get_by(PhraserMaster.Team, team_id: decoded_response["team_id"]) do
      nil ->
        PhraserMaster.Team.new(decoded_response)
        |> PhraserMaster.Repo.insert()

      team ->
        PhraserMaster.Team.changeset(team, decoded_response)
        |> PhraserMaster.Repo.update()
    end
  end
end
