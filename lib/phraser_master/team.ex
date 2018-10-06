defmodule PhraserMaster.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field(:team_id, :string)
    field(:user_id, :string)
    field(:team_name, :string)
    field(:access_token, :string)
    field(:scope, :string)

    field(:bot_user_id, :string)
    field(:bot_access_token, :string)

    timestamps()
  end

  def changeset(team, slack_payload) do
    team
    |> cast(slack_payload, ["team_id", "user_id", "team_name", "access_token", "scope"])
    |> cast(slack_payload["bot"], ["bot_user_id", "bot_access_token"])
  end

  def new(slack_payload) do
    %__MODULE__{
      team_id: slack_payload["team_id"],
      user_id: slack_payload["user_id"],
      team_name: slack_payload["team_name"],
      access_token: slack_payload["access_token"],
      scope: slack_payload["scope"],
      bot_user_id: slack_payload["bot"]["bot_user_id"],
      bot_access_token: slack_payload["bot"]["bot_access_token"]
    }
  end
end
