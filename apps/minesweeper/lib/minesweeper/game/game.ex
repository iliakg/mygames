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
        GenServer.cast(via_tuple(game_id), {:reset_state, opts})
        {:ok, pid}
    end
  end

  def open_cell(game_id, col, row) do
    GenServer.call(via_tuple(game_id), {:open_cell, col, row})
  end

  def battlefield(game_id) do
    GenServer.call(via_tuple(game_id), :battlefield)
  end

  def opened_cells(game_id) do
    GenServer.call(via_tuple(game_id), :opened_cells)
  end

  defp via_tuple(game_id) do
    {:via, :gproc, {:n, :l, {:game_id, game_id}}}
  end

  # SERVER
  def init(state) do
    {:ok, state}
  end

  def handle_cast({:reset_state, opts}, _state) do
    {:noreply, Battlestate.init(opts)}
  end

  def handle_call({:open_cell, col, row}, _from, state) do
    {current_changes, new_state} = Battlestate.open_cell(state, col, row)
    {:reply, {new_state.status, current_changes}, new_state}
  end

  def handle_call(:battlefield, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:opened_cells, _from, state) do
    {:reply, {state.status, state.opened_cells}, state}
  end
end
