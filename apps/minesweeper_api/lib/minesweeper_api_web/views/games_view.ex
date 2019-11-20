defmodule MinesweeperApiWeb.GamesView do
  use MinesweeperApiWeb, :view

  def render("init_game.json", %{status: status, opened_cells: opened_cells}) do
    %{
      status: status,
      opened_cells: opened_cells
    }
  end
end
