defmodule MinesweeperApiWeb.GamesView do
  use MinesweeperApiWeb, :view

  def render("create.json", %{status: status}) do
    %{
      test: status
    }
  end
end
