defmodule PhraserMaster.Repo.Migrations.CreateWeeks do
  use Ecto.Migration

  def change do
    create table(:weeks) do
      add(:number, :integer)
      add(:tribe, :string)
      add(:slack_username, :string)
      add(:start_at, :date)
      add(:end_at, :date)

      timestamps()
    end
  end
end
