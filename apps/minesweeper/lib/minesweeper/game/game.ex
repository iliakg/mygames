defmodule Minesweeper.Game do
  use GenServer

  @moduledoc """
  """

  alias Minesweeper.Game.Battlestate

  # CLIENT
  @spec start_link(any, %{bombs_count: pos_integer(), x: pos_integer(), y: pos_integer()}) :: {:ok, any}
  def start_link(game_id, opts \\ %{}) do
    GenServer.start_link(__MODULE__, Battlestate.init(opts), name: via_tuple(game_id))
  end

  def reset_state(game_id, opts) do
    GenServer.call(via_tuple(game_id), {:reset_state, opts})
  end

  def open_cell(game_id, col, row) do
    GenServer.call(via_tuple(game_id), {:open_cell, col, row})
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

  def handle_call({:reset_state, opts}, _from, _state) do
    new_state = Battlestate.init(opts)
    {:reply, new_state, new_state}
  end

  def handle_call({:open_cell, col, row}, _from, state) do
    {current_changes, new_state} = Battlestate.open_cell(state, col, row)
    {:reply, {new_state.status, current_changes}, new_state}
  end

  def handle_call(:battlefield, _from, state) do
    {:reply, state, state}
  end
end
