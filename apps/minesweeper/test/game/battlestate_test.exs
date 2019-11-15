defmodule Minesweeper.Game.BattlestateTest do
  use ExUnit.Case
  doctest Minesweeper

  @tag :battlestate
  test "default init" do
    Minesweeper.Game.Battlestate.init()
    |> IO.inspect()
  end
end
