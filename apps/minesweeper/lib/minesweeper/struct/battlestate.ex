defmodule Minesweeper.Struct.Battlestate do
  @moduledoc """
  State of game
  """
  @type t :: %__MODULE__{
          opts: map(),
          minefield: map(),
          cleared_minefield: map()
        }

  defstruct opts: %{},
            minefield: %{},
            cleared_minefield: %{}
end
