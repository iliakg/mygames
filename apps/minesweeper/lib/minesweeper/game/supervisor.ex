defmodule Minesweeper.Game.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_game(game_id, opts \\ %{}) do
    Supervisor.start_child(__MODULE__, [game_id, opts])
  end

  def init(_) do
    children = [
      worker(Minesweeper.Game, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
