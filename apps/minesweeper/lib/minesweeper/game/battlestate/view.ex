defmodule Minesweeper.Game.Battlestate.View do
  @moduledoc """
  """

  import Minesweeper.Game.Battlestate.Helper, only: [location: 1]

  alias Minesweeper.Struct.Battlestate

  @spec pretty(Battlestate.t()) :: [[any]]
  def pretty(%Battlestate{minefield: minefield, opts: %{x: x}}) do
    minefield
    |> Enum.sort(fn a1, a2 ->
      {c1, _} = a1
      {c2, _} = a2
      [x1 | [y1]] = location(c1)
      [x2 | [y2]] = location(c2)
      [y1, x1] < [y2, x2]
    end)
    |> Enum.map(fn x -> {_, val} = x; val end)
    |> Enum.chunk_every(x)
  end
end
