defmodule Minesweeper.Struct.Battlestate do
  @moduledoc """
  State of game
  """
  @type t :: %__MODULE__{
          opts: map(),
          minefield: map(),
          opened_cells: map()
        }

  defstruct opts: %{},
            minefield: %{},
            opened_cells: %{}
end
