defmodule ScoreGoblin.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string

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
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end
end
