defmodule ScoreGoblinWeb.PlayerHTML do
  use ScoreGoblinWeb, :html

  embed_templates "player_html/*"

  @doc """
  Renders a player form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def player_form(assigns)
end