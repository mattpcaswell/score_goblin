defmodule ScoreGoblin.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScoreGoblin.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        status: :planned,
        date: ~U[2023-08-22 22:33:00Z]
      })
      |> ScoreGoblin.Games.create_game()

    game
  end
end
