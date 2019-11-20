defmodule MinesweeperApiWeb.GamesController do
  use MinesweeperApiWeb, :controller

  def init_game(conn, %{"game_id" => game_id, "rows" => _rows, "cols" => _cols, "bombs" => _bombs}) do
    Minesweeper.Game.Supervisor.start_game(game_id, %{rows: 3, cols: 4, bombs_count: 2})
    %{status: status, opened_cells: opened_cells} = Minesweeper.Game.battlefield(game_id)

    conn
    |> put_status(:ok)
    |> render("init_game.json", %{status: status, opened_cells: opened_cells})
  end
end
