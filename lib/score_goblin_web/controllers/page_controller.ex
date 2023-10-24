defmodule ScoreGoblinWeb.PageController do
  use ScoreGoblinWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    all_games = ScoreGoblin.Games.list_games()
    render(conn, :home, all_games: all_games)
  end
end
