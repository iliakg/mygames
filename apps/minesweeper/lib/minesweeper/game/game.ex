defmodule Minesweeper.Game do
  use GenServer

  @moduledoc """
  """

  alias Minesweeper.Game.Battlestate

  # CLIENT
  @spec start_link(any, %{bombs_count: pos_integer(), x: pos_integer(), y: pos_integer()}) :: {:ok, any}
  def start_link(game_id, opts \\ %{}) do
    case GenServer.start_link(__MODULE__, Battlestate.init(opts), name: via_tuple(game_id)) do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        # TODO change state
        IO.inspect "already_started"
        {:ok, pid}
    end
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

  def handle_call(:battlefield, _from, state) do
    {:reply, state, state}
  end
end
