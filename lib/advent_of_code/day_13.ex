defmodule AdventOfCode.Day13 do
  def parse("fold along y=" <> pos), do: {:fold, :y, String.to_integer(pos)}
  def parse("fold along x=" <> pos), do: {:fold, :x, String.to_integer(pos)}

  def parse(x) do
    x |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
  end

  def draw(grid, max_x, max_y) do
    {:ok, buffer} = StringIO.open("")

    for y <- 0..max_y do
      for x <- 0..max_x do
        IO.write(buffer, Map.get(grid, {x, y}, " "))
      end

      IO.puts(buffer, "")
    end

    {:ok, {"", content}} = StringIO.close(buffer)
    content
  end

  def fold(grid, {:fold, :x, pos}, max_x, _max_y) do
    need_folding = Enum.filter(grid, fn {{x, _y}, _} -> x > pos end)
    folded = Map.reject(grid, fn x -> x in need_folding end)

    Enum.reduce(need_folding, folded, fn {{x, y}, val}, map ->
      Map.put(map, {max_x - x, y}, val)
    end)
  end

  def fold(grid, {:fold, :y, pos}, _max_x, max_y) do
    need_folding = Enum.filter(grid, fn {{_x, y}, _} -> y > pos end)
    folded = Map.reject(grid, fn x -> x in need_folding end)

    Enum.reduce(need_folding, folded, fn {{x, y}, val}, map ->
      Map.put(map, {x, max_y - y}, val)
    end)
  end

  def folds(grid, folds) do
    Enum.reduce(folds, grid, fn fold, grid ->
      {max_x, max_y} = max(grid)
      fold(grid, fold, max_x, max_y)
    end)
  end

  def max(grid) do
    {{max_x, _y}, _} = Enum.max_by(grid, fn {{x, _y}, _} -> x end)
    {{_x, max_y}, _} = Enum.max_by(grid, fn {{_x, y}, _} -> y end)
    {max_x, max_y}
  end

  def part1(args) do
    {grid, folds} =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)
      |> Enum.reduce({%{}, []}, fn
        [x, y], {grid, folds} -> {Map.put(grid, {x, y}, "█"), folds}
        {:fold, _, _} = fold, {grid, folds} -> {grid, [fold | folds]}
      end)

    # We need to know the max x, and max y
    {max_x, max_y} = max(grid)

    fold(grid, List.last(folds), max_x, max_y)
    |> Enum.count(fn {_, val} -> val == "█" end)

    # |> then(fn {grid, folds} -> fold(grid, Enum.reverse(folds)) end)
  end

  def part2(args) do
    {grid, folds} =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)
      |> Enum.reduce({%{}, []}, fn
        [x, y], {grid, folds} -> {Map.put(grid, {x, y}, "█"), folds}
        {:fold, _, _} = fold, {grid, folds} -> {grid, [fold | folds]}
      end)

    folds = Enum.reverse(folds)

    solution = folds(grid, folds)

    {x, y} = max(solution)
    draw(solution, x, y)
  end
end
