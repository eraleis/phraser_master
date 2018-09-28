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

  def current_week! do
    {:ok, week} = current_week()
    week
  end

  defp current_week do
    __MODULE__.get_by(Week, number: PhraserMaster.Date.unix_week!())
    |> create_or_return_week()
  end

  defp create_or_return_week(nil) do
    Week.new()
    |> __MODULE__.insert()
  end

  defp create_or_return_week(week), do: {:ok, week}
end
