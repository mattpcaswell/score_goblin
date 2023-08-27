defmodule ScoreGoblin.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :status, Ecto.Enum, values: [:planned, :in_progress, :finished, :canceled]
    field :date, :utc_datetime

    many_to_many(
      :players, 
      ScoreGoblin.Accounts.User, 
      join_through: ScoreGoblin.Games.Participant, 
      join_keys: [game_id: :id, player_id: :id], 
      unique: true, 
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:status, :date])
    |> validate_required([:status, :date])
  end
end
