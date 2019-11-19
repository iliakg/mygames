defmodule Minesweeper.Game.Battlestate.Helper do
  @moduledoc """
  """

  # GAME FUNCTIONS

  @spec validate_opts(%{bombs_count: any, x: any, y: any}) :: %{
          bombs_count: any,
          x: any,
          y: any
        }
  def validate_opts(opts) do
    %{x: opts.x, y: opts.y, bombs_count: opts.bombs_count}
  end

  @spec lets_start(map(), String.t()) :: [map()]
  def lets_start(opts, position) do
    minefield = init_bombs(init_field(opts.x, opts.y), position, opts.bombs_count)
    opened_cells = change_cell(%{}, minefield, position)

    [minefield, opened_cells]
  end

  @spec change_cell(map(), map(), String.t()) :: map()
  def change_cell(opened_cells, minefield, cell_position) do
    case opened_cells[cell_position] do
      nil ->
        case minefield[cell_position] do
          nil ->
            opened_cells

          0 ->
            [x | [y]] = location(cell_position)

            Map.put(opened_cells, cell_position, 0)
            |> change_cell(minefield, location(x - 1, y - 1))
            |> change_cell(minefield, location(x - 1, y))
            |> change_cell(minefield, location(x - 1, y + 1))
            |> change_cell(minefield, location(x, y - 1))
            |> change_cell(minefield, location(x, y + 1))
            |> change_cell(minefield, location(x + 1, y - 1))
            |> change_cell(minefield, location(x + 1, y))
            |> change_cell(minefield, location(x + 1, y + 1))

          val ->
            Map.put(opened_cells, cell_position, val)
        end

      _ ->
        opened_cells
    end
  end

  # HELPER FUNCTIONS

  @spec location(integer(), integer()) :: String.t()
  def location(i, j), do: "#{i}_#{j}"

  @spec location(String.t()) :: [integer()]
  def location(val), do: String.split(val, "_") |> Enum.map(&String.to_integer/1)

  # PRIVATE FUNCTIONS
  defp init_field(i, j, area \\ %{}, index_i \\ 0, index_j \\ 0)

  defp init_field(i, j, area, index_i, index_j) when i > index_i and j > index_j,
    do: init_field(i, j, Map.put(area, location(index_i, index_j), 0), index_i + 1, index_j)

  defp init_field(i, j, area, index_i, index_j) when i == index_i and j > index_j,
    do: init_field(i, j, area, 0, index_j + 1)

  defp init_field(_, _, area, _, _), do: area

  defp init_bombs(minefield, start_position, bombs_count) do
    set_bombs(minefield, bombs_keys(minefield, start_position, bombs_count))
  end

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
