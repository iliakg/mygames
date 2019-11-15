defmodule Minesweeper.Game.Battlestate do
  @moduledoc """
  """
  import Minesweeper.Game.Battlestate.Helper

  alias Minesweeper.Struct.Battlestate

  # Minesweeper.Game.Battlestate.init
  @spec init(any) :: Battlestate.t()
  def init(opts \\ %{}) do
    x = 14
    y = 8
    bombs_count = 4
    start_position = "2_1"

    minefield = init_field(x, y)

    bombs_minefield = set_bombs(minefield, bombs_keys(minefield, start_position, bombs_count))

    %Battlestate{
      opts: %{x: x, y: y, bombs_count: bombs_count, start_position: start_position},
      minefield: bombs_minefield,
      cleared_minefield: minefield
    }
  end
end
