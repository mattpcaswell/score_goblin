defmodule ScoreGoblin.Players do
  @moduledoc """
  The Players context.
  """

  import Ecto.Query, warn: false
  alias ScoreGoblin.Repo

  alias ScoreGoblin.Players.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Player
    |> Repo.all()
    |> Repo.preload([:games, :participant])
    |> get_stats_for_all()
  end

  defp get_stats_for_all(list) do
    get_stats(list)
  end
  defp get_stats([%Player{} = player | rest]) do
    player = %{player | wins: num_wins(player)}
    player = %{player | losses: num_losses(player)}
    player = %{player | ties: num_ties(player)}

    [player | get_stats(rest)]
  end
  defp get_stats([]) do
    []
  end

  defp num_wins(%Player{} = player) do
    Enum.count(player.participant, &(&1.status == :won))
  end
  defp num_losses(%Player{} = player) do
    Enum.count(player.participant, &(&1.status == :lost))
  end
  defp num_ties(%Player{} = player) do
    Enum.count(player.participant, &(&1.status == :tie))
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player(123)
      %Player{}

      iex> get_player(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id) do
    Player
    |> Repo.get!(id)
    |> Repo.preload(games: [:players])
  end

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end
end
