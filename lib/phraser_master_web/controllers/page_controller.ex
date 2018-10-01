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
        }",
        "",
        [{"Content-type", "application/x-www-form-urlencoded"}]
      )

    decoded_response = Poison.decode!(response.body)

    case Map.take(Poison.decode!(response.body), ["ok"]) do
      %{"ok" => true} ->
        text(conn, "Successfuly added to your slack app.")

      _ ->
        text(conn, "Oups, there is an error: #{decoded_response["error"]}")
    end
  end
end
