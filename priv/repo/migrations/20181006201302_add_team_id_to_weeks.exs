defmodule PhraserMaster.Repo.Migrations.AddTeamIdToWeeks do
  use Ecto.Migration

  def change do
    alter table(:weeks) do
      add(:team_id, references(:teams))
    end
  end
end
