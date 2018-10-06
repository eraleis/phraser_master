defmodule PhraserMaster.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:team_id, :string)
      add(:user_id, :string)
      add(:team_name, :string)
      add(:access_token, :string)
      add(:scope, :string)

      add(:bot_user_id, :string)
      add(:bot_access_token, :string)

      timestamps()
    end
  end
end
