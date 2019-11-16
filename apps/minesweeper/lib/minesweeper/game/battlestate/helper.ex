defmodule Minesweeper.Game.Battlestate.Helper do
  @moduledoc """
  """

  # INIT FUNCTIONS

  @spec init_field(integer(), integer(), integer(), map(), integer(), integer()) :: map()
  def init_field(i, j, dval, area \\ %{}, index_i \\ 0, index_j \\ 0)

  def init_field(i, j, dval, area, index_i, index_j) when i > index_i and j > index_j,
    do:
      init_field(
        i,
        j,
        dval,
        Map.put(area, location(index_i, index_j), dval),
        index_i + 1,
        index_j
      )

  def init_field(i, j, dval, area, index_i, index_j) when i == index_i and j > index_j,
    do: init_field(i, j, dval, area, 0, index_j + 1)

  def init_field(_, _, _, area, _, _), do: area

  @spec init_bombs(map(), String.t(), integer()) :: map()
  def init_bombs(minefield, start_position, bombs_count) do
    set_bombs(minefield, bombs_keys(minefield, start_position, bombs_count))
  end

  # HELPER FUNCTIONS

  @spec location(integer(), integer()) :: String.t()
  def location(i, j), do: "#{i}_#{j}"

  @spec location(String.t()) :: [integer()]
  def location(val), do: String.split(val, "_") |> Enum.map(&String.to_integer/1)

  def open_cell(cleared_minefield, minefield, cell_position) do
    case cleared_minefield[cell_position] do
      "-" ->
        case minefield[cell_position] do
          0 ->
            [x | [y]] = location(cell_position)

            Map.put(cleared_minefield, cell_position, 0)
            |> open_cell(minefield, location(x - 1, y - 1))
            |> open_cell(minefield, location(x - 1, y))
            |> open_cell(minefield, location(x - 1, y + 1))
            |> open_cell(minefield, location(x, y - 1))
            |> open_cell(minefield, location(x, y + 1))
            |> open_cell(minefield, location(x + 1, y - 1))
            |> open_cell(minefield, location(x + 1, y))
            |> open_cell(minefield, location(x + 1, y + 1))

          val ->
            Map.put(cleared_minefield, cell_position, val)
        end

      _ ->
        cleared_minefield
    end
  end

  # PRIVATE FUNCTIONS

  defp bombs_keys(minefield, start_position, bombs_count) do
    Map.keys(minefield)
    |> List.delete(start_position)
    |> Enum.shuffle()
    |> Enum.take(bombs_count)
  end

  defp set_bombs(area, [h | keys]) do
    Map.put(area, h, "x")
    |> set_bombs(keys)
    |> set_nums_around_bomb(h)
  end

  defp set_bombs(area, []), do: area

  defp set_nums_around_bomb(area, cell_position) do
    [x | [y]] = location(cell_position)

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

  defp increment_num(area, cell_position) do
    case area[cell_position] do
      "x" ->
        area

      nil ->
        area

      val ->
        Map.put(area, cell_position, val + 1)
    end
  end
end
