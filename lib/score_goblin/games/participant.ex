defmodule ScoreGoblin.Games.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "participants" do
    field :status, Ecto.Enum, values: [:won, :lost, :tie, :none], default: :none
    field :points, :integer, default: 0

    belongs_to :user, ScoreGoblin.Accounts.User, foreign_key: :player_id
    belongs_to :game, ScoreGoblin.Games.Game

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status, :points, :user_id, :game_id])
    |> validate_required([:status, :points, :user_id, :game_id])
  end
end
