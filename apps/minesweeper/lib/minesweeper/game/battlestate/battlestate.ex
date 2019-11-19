defmodule Minesweeper.Game.Battlestate do
  @moduledoc """
  """
  import Minesweeper.Game.Battlestate.Helper

  alias Minesweeper.Struct.Battlestate

  # Minesweeper.Game.Battlestate.init(%{cols: 4, rows: 3, bombs_count: 3})
  @spec init(%{bombs_count: pos_integer(), cols: pos_integer(), rows: pos_integer()}) :: Battlestate.t()
  def init(opts \\ %{}) do
    %Battlestate{
      status: :init,
      opts: validate_opts(opts),
      minefield: %{},
      opened_cells: %{}
    }
  end

  @spec open_cell(Battlestate.t(), String.t()) :: {map(), Battlestate.t()}
  def open_cell(%Battlestate{} = state, position) do
    case state.status do
      :init ->
        {minefield, opened_cells} = lets_start(state.opts, position)

        {
          opened_cells,
          %Battlestate{
            status: :started,
            opts: state.opts,
            minefield: minefield,
            opened_cells: opened_cells
          }
        }

      :started ->
        {opened_cells, current_state} =
          change_cell({state.opened_cells, %{}}, state.minefield, position)

        status =
          if opened_cells[position] == "x" do
            :failed
          else
            :started
          end

        {
          current_state,
          %Battlestate{
            status: status,
            opts: state.opts,
            minefield: state.minefield,
            opened_cells: opened_cells
          }
        }

      _ ->
        {%{}, state}
    end
  end
end
