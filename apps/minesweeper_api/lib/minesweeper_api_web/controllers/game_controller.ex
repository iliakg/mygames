defmodule MinesweeperApiWeb.GamesController do
  use MinesweeperApiWeb, :controller

  def create(conn, %{"game_id" => game_id, "rows" => rows, "cols" => cols, "bombs" => bombs}) do
    Minesweeper.Game.Supervisor.start_game(game_id, %{rows: 3, cols: 4, bombs_count: 2})

    conn
    |> put_status(:ok)
    |> render("create.json", %{status: "ok"})
  end
end
