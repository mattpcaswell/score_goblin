defmodule ScoreGoblin.Repo.Migrations.SwitchUsersToPlayers do
  use Ecto.Migration

  def change do
    rename table(:users), to: table(:players)

    alter table(:players) do
      remove :email, :string, default: "lost@email.com"
    end
  end
end
