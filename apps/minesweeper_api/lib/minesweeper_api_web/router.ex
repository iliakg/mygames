defmodule MinesweeperApiWeb.Router do
  use MinesweeperApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MinesweeperApiWeb do
    pipe_through :api


    scope "/minesweeper" do
      post "/", GamesController, :init_game
      post "/reset_game", GamesController, :reset_game
      post "/open_cell", GamesController, :open_cell
    end
  end
end
