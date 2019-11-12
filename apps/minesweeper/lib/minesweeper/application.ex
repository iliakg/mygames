defmodule Minesweeper.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Minesweeper.Game.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Minesweeper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
