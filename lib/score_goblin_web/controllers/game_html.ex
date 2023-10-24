defmodule ScoreGoblinWeb.GameHTML do
  use ScoreGoblinWeb, :html

  embed_templates "game_html/*"

  @doc """
  Renders a game form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def game_form(assigns)

  @doc """
  Renders a game list.
  """
  attr :games, :list, required: true

  def game_list(assigns)

  defp player_names(game) do
    names = 
      game.players
      |> Enum.map(fn(player) -> player.name end)
      |> Enum.join(", ")

    if String.length(names) == 0 do 
      "None"
    else
      names
    end
  end

  defp player_options(changeset) do
    current_players = 
      changeset
      |> Ecto.Changeset.get_change(:players, [])
      |> Enum.map(& &1.data.id)

    for player <- ScoreGoblin.Players.list_players() do
      [key: player.name, value: player.id, selected: player.id in current_players]
    end
  end
end
