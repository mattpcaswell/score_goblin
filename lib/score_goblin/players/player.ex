defmodule ScoreGoblin.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string

    field :wins, :integer, virtual: true
    field :losses, :integer, virtual: true
    field :ties, :integer, virtual: true

    has_many :participant, ScoreGoblin.Games.Participant

    many_to_many(
      :games, 
      ScoreGoblin.Games.Game,
      join_through: ScoreGoblin.Games.Participant, 
      join_keys: [player_id: :id, game_id: :id], 
      unique: true, 
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
