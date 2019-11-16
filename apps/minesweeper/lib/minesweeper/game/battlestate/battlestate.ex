defmodule Minesweeper.Game.Battlestate do
  @moduledoc """
  """
  import Minesweeper.Game.Battlestate.Helper

  alias Minesweeper.Struct.Battlestate

  # Minesweeper.Game.Battlestate.init
  @spec init(any) :: Battlestate.t()
  def init(opts \\ %{}) do
    x = 3
    y = 3
    bombs_count = 4
    start_position = "2_1"

    bombs_minefield = init_bombs(init_field(x, y, 0), start_position, bombs_count)
    cleared_minefield = open_cell(init_field(x, y, "-"), bombs_minefield, start_position)

    %Battlestate{
      opts: %{x: x, y: y, bombs_count: bombs_count, start_position: start_position},
      minefield: bombs_minefield,
      cleared_minefield: cleared_minefield
    }
  end
end
