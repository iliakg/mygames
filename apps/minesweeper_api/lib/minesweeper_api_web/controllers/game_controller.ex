defmodule MinesweeperApiWeb.GamesController do
  use MinesweeperApiWeb, :controller

  alias Minesweeper.Struct.Battlestate

  def init_game(conn, %{
        "game_id" => game_id,
        "rows" => rows,
        "cols" => cols,
        "bombs" => bombs
      }) do
    params = prepare_params(rows, cols, bombs)

    Minesweeper.Game.Supervisor.start_game(game_id, %{
      rows: params.rows,
      cols: params.cols,
      bombs_count: params.bombs_count
    })

    %Battlestate{status: status, opts: opts, opened_cells: opened_cells} =
      Minesweeper.Game.battlefield(game_id)

    conn
    |> put_status(:ok)
    |> render("init_game.json", %{status: status, opts: opts, opened_cells: opened_cells})
  end

  def reset_game(conn, %{
        "game_id" => game_id,
        "rows" => rows,
        "cols" => cols,
        "bombs" => bombs
      }) do
    params = prepare_params(rows, cols, bombs)

    try do
      case Minesweeper.Game.reset_state(game_id, %{
             rows: params.rows,
             cols: params.cols,
             bombs_count: params.bombs_count
           }) do
        %Battlestate{status: status, opts: opts, opened_cells: opened_cells} ->
          conn
          |> put_status(:ok)
          |> render("reset_game.json", %{status: status, opts: opts, opened_cells: opened_cells})

        _ ->
          bad_request(conn)
      end
    catch
      :exit, _reason -> bad_request(conn)
    end
  end

  def open_cell(conn, %{"game_id" => game_id, "row" => row, "col" => col}) do
    {status, opened_cells} =
      Minesweeper.Game.open_cell(game_id, String.to_integer(col), String.to_integer(row))

    conn
    |> put_status(:ok)
    |> render("open_cell.json", %{status: status, opened_cells: opened_cells})
  end

  defp prepare_params(rows, cols, bombs_count) do
    try do
      with rows when rows > 0 <- String.to_integer(rows),
           cols when cols > 0 <- String.to_integer(cols),
           bombs_count when bombs_count > 0 <- String.to_integer(bombs_count),
           bombs_count <- validate_bombs(rows, cols, bombs_count) do
        %{rows: rows, cols: cols, bombs_count: bombs_count}
      else
        _ ->
          %{rows: 9, cols: 9, bombs_count: 10}
      end
    rescue
      _ ->
        %{rows: 9, cols: 9, bombs_count: 10}
    end
  end

  defp validate_bombs(rows, cols, bombs_count) do
    cond do
      rows * cols > bombs_count -> bombs_count
      true -> Kernel.trunc(rows * cols * 0.2)
    end
  end

  defp bad_request(conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(MinesweeperApiWeb.ErrorsView)
    |> render("400.json")
  end
end
