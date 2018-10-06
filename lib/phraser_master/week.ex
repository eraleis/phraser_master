defmodule PhraserMaster.Week do
  use Ecto.Schema
  import Ecto.Changeset

  @tribes ["Talent Aquisition", "Users Journey", "Career Services"]

  schema "weeks" do
    field(:number, :integer)
    field(:tribe, :string)
    field(:slack_username, :string)
    field(:start_at, :date)
    field(:end_at, :date)

    belongs_to(:team, PhraserMaster.Team)

    timestamps()
  end

  def new(team_id) do
    %__MODULE__{
      team_id: team_id,
      number: PhraserMaster.Date.unix_week!(),
      tribe: choose_tribe(),
      start_at: PhraserMaster.Date.monday(),
      end_at: Date.add(PhraserMaster.Date.monday(), 6)
    }
  end

  def slack_username_changeset(week, params) do
    week
    |> cast(params, [:slack_username])
  end

  defp choose_tribe do
    index =
      PhraserMaster.Date.unix_week!()
      |> Kernel.rem(3)

    @tribes
    |> Enum.at(index)
  end
end
