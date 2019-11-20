defmodule MinesweeperApiWeb.GamesController do
  use MinesweeperApiWeb, :controller

  alias Minesweeper.Struct.Battlestate

  def init_game(conn, %{"game_id" => game_id, "rows" => _rows, "cols" => _cols, "bombs" => _bombs}) do
    Minesweeper.Game.Supervisor.start_game(game_id, %{rows: 3, cols: 4, bombs_count: 2})

    %Battlestate{status: status, opened_cells: opened_cells} =
      Minesweeper.Game.battlefield(game_id)

    conn
    |> put_status(:ok)
    |> render("init_game.json", %{status: status, opened_cells: opened_cells})
  end

  def reset_game(conn, %{
        "game_id" => game_id,
        "rows" => _rows,
        "cols" => _cols,
        "bombs" => _bombs
      }) do
    try do
      case Minesweeper.Game.reset_state(game_id, %{rows: 3, cols: 4, bombs_count: 2}) do
        %Battlestate{status: status, opened_cells: opened_cells} ->
          conn
          |> put_status(:ok)
          |> render("reset_game.json", %{status: status, opened_cells: opened_cells})

        _ ->
          bad_request(conn)
      end
    catch
      :exit, _reason -> bad_request(conn)
    end
  end

  defp bad_request(conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(MinesweeperApiWeb.ErrorsView)
    |> render("400.json")
  end
end
