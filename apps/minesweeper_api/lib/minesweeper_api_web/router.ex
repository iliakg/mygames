defmodule MinesweeperApiWeb.Router do
  use MinesweeperApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MinesweeperApiWeb do
    pipe_through :api


    scope "/minesweeper" do
      post "/", GamesController, :create
    end
  end
end
