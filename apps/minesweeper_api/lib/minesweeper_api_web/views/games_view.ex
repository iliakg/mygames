defmodule MinesweeperApiWeb.GamesView do
  use MinesweeperApiWeb, :view

  def render("init_game.json", %{status: status, opts: opts, opened_cells: opened_cells}) do
    %{
      status: status,
      opts: opts,
      opened_cells: opened_cells
    }
  end

  def render("reset_game.json", %{status: status, opts: opts, opened_cells: opened_cells}) do
    %{
      status: status,
      opts: opts,
      opened_cells: opened_cells
    }
  end

  def render("open_cell.json", %{status: status, opened_cells: opened_cells}) do
    %{
      status: status,
      opened_cells: opened_cells
    }
  end
end
