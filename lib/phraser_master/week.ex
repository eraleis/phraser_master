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

    timestamps()
  end

  def new do
    %__MODULE__{
      number: PhraserMaster.Date.unix_week!(),
      tribe: choose_tribe(),
      start_at: PhraserMaster.Date.monday(),
      end_at: Date.add(PhraserMaster.Date.monday(), 6)
    }
  end

  defp choose_tribe do
    index =
      PhraserMaster.Date.unix_week!()
      |> Kernel.rem(3)

    @tribes
    |> Enum.at(index)
  end
end
