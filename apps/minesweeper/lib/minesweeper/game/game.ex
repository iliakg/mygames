defmodule Minesweeper.Game do
  use GenServer

  @moduledoc """
  """
  # CLIENT
  def start_link(game_id, opts \\ %{}) do
    GenServer.start_link(__MODULE__, Minesweeper.Game.Battlestate.init(opts), name: via_tuple(game_id))
  end

  def battlefield(game_id) do
    GenServer.call(via_tuple(game_id), :battlefield)
  end

  defp via_tuple(game_id) do
    {:via, :gproc, {:n, :l, {:game_id, game_id}}}
  end

  # SERVER
  def init(state) do
    {:ok, state}
  end

  def handle_call(:battlefield, _from, deck) do
    {:reply, deck, deck}
  end
end
