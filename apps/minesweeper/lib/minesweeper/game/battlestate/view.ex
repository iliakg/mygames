defmodule Minesweeper.Game.Battlestate.View do
  @moduledoc """
  """

  import Minesweeper.Game.Battlestate.Helper, only: [location: 1]

  alias Minesweeper.Struct.Battlestate

  @spec pretty_minefield(Battlestate.t()) :: [[any]]
  def pretty_minefield(%Battlestate{minefield: minefield, opts: %{x: x}}) do
    pretty(minefield, x)
  end

  @spec pretty_cleared_minefield(Battlestate.t()) :: [[any]]
  def pretty_cleared_minefield(%Battlestate{cleared_minefield: cleared_minefield, opts: %{x: x}}) do
    pretty(cleared_minefield, x)
  end

  defp pretty(area, chunk_size) do
    area
    |> Enum.sort(fn a1, a2 ->
      {c1, _} = a1
      {c2, _} = a2
      [x1 | [y1]] = location(c1)
      [x2 | [y2]] = location(c2)
      [y1, x1] < [y2, x2]
    end)
    |> Enum.map(fn x -> {_, val} = x; val end)
    |> Enum.chunk_every(chunk_size)
  end
end
