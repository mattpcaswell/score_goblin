defmodule ScoreGoblin.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :status, :string
      add :points, :integer, default: 0

      add :game_id, references("games", on_delete: :delete_all)
      add :player_id, references("users", on_delete: :delete_all)

      timestamps()
    end
  end
end
