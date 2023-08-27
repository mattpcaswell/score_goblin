defmodule ScoreGoblin.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :status, :string
      add :date, :utc_datetime

      timestamps()
    end
  end
end
