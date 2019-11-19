defmodule Minesweeper.Struct.Battlestate do
  @moduledoc """
  State of game
  """
  @type t :: %__MODULE__{
          status: String.t(),
          opts: map(),
          minefield: map(),
          opened_cells: map()
        }

  defstruct status: "",
            opts: %{},
            minefield: %{},
            opened_cells: %{}
end
