defmodule ScoreGoblin.Repo do
  use Ecto.Repo,
    otp_app: :score_goblin,
    adapter: Ecto.Adapters.Postgres
end
