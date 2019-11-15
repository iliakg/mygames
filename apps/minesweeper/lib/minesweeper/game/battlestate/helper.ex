defmodule Minesweeper.Game.Battlestate.Helper do
  @moduledoc """
  """

  @spec location(integer(), integer()) :: String.t()
  def location(i, j), do: "#{i}_#{j}"

  @spec location(String.t()) :: [integer()]
  def location(val), do: String.split(val, "_") |> Enum.map(&String.to_integer/1)

  @spec init_field(integer(), integer(), map(), integer(), integer()) :: map()
  def init_field(i, j, area \\ %{}, index_i \\ 0, index_j \\ 0)

  def init_field(i, j, area, index_i, index_j) when i > index_i and j > index_j,
    do: init_field(i, j, Map.put(area, location(index_i, index_j), 0), index_i + 1, index_j)

  def init_field(i, j, area, index_i, index_j) when i == index_i and j > index_j,
    do: init_field(i, j, area, 0, index_j + 1)

  def init_field(_, _, area, _, _), do: area

  @spec bombs_keys(map(), String.t(), integer()) :: [any()]
  def bombs_keys(minefield, start_position, bombs_count) do
    Map.keys(minefield)
    |> List.delete(start_position)
    |> Enum.shuffle()
    |> Enum.take(bombs_count)
  end

  @spec set_bombs(map(), [String.t()]) :: map()
  def set_bombs(area, [h | keys]) do
    Map.put(area, h, "x")
    |> set_bombs(keys)
    |> set_nums_around_bomb(h)
  end

  def set_bombs(area, []), do: area

  @spec set_nums_around_bomb(map(), String.t()) :: map()
  def set_nums_around_bomb(area, cell) do
    [x | [y]] = location(cell)

    area
    |> increment_num(location(x - 1, y - 1))
    |> increment_num(location(x - 1, y))
    |> increment_num(location(x - 1, y + 1))
    |> increment_num(location(x, y - 1))
    |> increment_num(location(x, y + 1))
    |> increment_num(location(x + 1, y - 1))
    |> increment_num(location(x + 1, y))
    |> increment_num(location(x + 1, y + 1))
  end

  @spec increment_num(map(), String.t()) :: map()
  def increment_num(area, cell) do
    case area[cell] do
      "x" ->
        area

      nil ->
        area

      val ->
        Map.put(area, cell, val + 1)
    end
  end
end
