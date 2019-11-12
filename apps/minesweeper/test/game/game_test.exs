defmodule Minesweeper.Game.StartLinkTest do
  use ExUnit.Case
  doctest Minesweeper

  @tag :game
  test "default game battlefield" do
    Minesweeper.Game.Supervisor.start_game("game_id", %{})

    Minesweeper.Game.battlefield("game_id")
    |> IO.inspect()
  end
end
