defmodule PhraserMaster.Repo do
  use Ecto.Repo, otp_app: :phraser_master
  alias PhraserMaster.Week

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def current_week!(team) do
    {:ok, week} = current_week(team)
    week
  end

  defp current_week(team) do
    import Ecto.Query

    number = PhraserMaster.Date.unix_week!()

    where(Week, team_id: ^team.id, number: ^number)
    |> one()
    |> create_or_return_week(team)
  end

  defp create_or_return_week(nil, team) do
    Week.new(team.id)
    |> __MODULE__.insert()
  end

  defp create_or_return_week(week, team), do: {:ok, week}
end
