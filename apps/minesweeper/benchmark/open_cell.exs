items = 500
Minesweeper.Game.Supervisor.start_game(1, %{rows: items, cols: items, bombs_count: Kernel.trunc(items * items * 0.2)})

start = System.monotonic_time(:millisecond)
Minesweeper.Game.open_cell(1, 0, 0)
time_spent = System.monotonic_time(:millisecond) - start
IO.puts("1 cell in #{time_spent}")

start = System.monotonic_time(:millisecond)
Minesweeper.Game.open_cell(1, items - 10, items - 10)
time_spent = System.monotonic_time(:millisecond) - start
IO.puts("2 cell in #{time_spent}")

start = System.monotonic_time(:millisecond)
Minesweeper.Game.open_cell(1, items - 100, items - 100)
time_spent = System.monotonic_time(:millisecond) - start
IO.puts("3 cell in #{time_spent}")
