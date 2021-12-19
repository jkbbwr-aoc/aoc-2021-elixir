defmodule AdventOfCode.Day11 do
  def neighbours(grid, {x, y}),
    do:
      [
        {x + 1, y, Map.get(grid, {x + 1, y})},
        {x - 1, y, Map.get(grid, {x - 1, y})},
        {x, y + 1, Map.get(grid, {x, y + 1})},
        {x, y - 1, Map.get(grid, {x, y - 1})},
        {x + 1, y + 1, Map.get(grid, {x + 1, y + 1})},
        {x - 1, y - 1, Map.get(grid, {x - 1, y - 1})},
        {x - 1, y + 1, Map.get(grid, {x - 1, y + 1})},
        {x + 1, y - 1, Map.get(grid, {x + 1, y - 1})}
      ]
      |> Enum.reject(fn {_, _, x} -> x == nil end)

  def count_and_reset(grid) do
    flashed = Map.filter(grid, fn {_, value} -> value == :flashed end)

    {
      Enum.reduce(flashed, grid, fn {{x, y}, _val}, acc -> Map.put(acc, {x, y}, 0) end),
      Enum.count(flashed)
    }
  end

  def targets(grid) do
    Map.filter(grid, fn
      {_key, value} -> value > 9 and value != :flashed
    end)
  end

  def propagate(grid, targets) when map_size(targets) == 0, do: grid

  def propagate(grid, targets) do
    Enum.reduce(targets, grid, fn {{x, y}, _val}, acc ->
      Enum.reduce(neighbours(acc, {x, y}), Map.replace!(acc, {x, y}, :flashed), fn
        {_dx, _dy, val}, acc when val == :flashed -> acc
        {dx, dy, val}, acc -> Map.put(acc, {dx, dy}, val + 1)
      end)
    end)
    |> then(fn g -> propagate(g, targets(g)) end)
  end

  def simulate(grid, steps \\ 100, count \\ 0)

  def simulate(_grid, 0, count), do: count

  def simulate(grid, steps, count) do
    grid
    |> Map.map(fn {_, value} -> value + 1 end)
    |> then(fn g -> propagate(g, targets(g)) end)
    |> count_and_reset()
    |> then(fn {g, c} -> simulate(g, steps - 1, count + c) end)
  end

  def is_in_sync?(grid) do
    Enum.all?(grid, fn {_, value} -> value == 0 end)
  end

  def find_sync(grid, step) do
    grid
    |> Map.map(fn {_, value} -> value + 1 end)
    |> then(fn g -> propagate(g, targets(g)) end)
    |> count_and_reset()
    |> then(fn
      {g, _} ->
        if is_in_sync?(g) do
          {g, step}
        else
          find_sync(g, step + 1)
        end
    end)
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, row}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, col}, acc ->
        Map.put(acc, {row, col}, String.to_integer(value))
      end)
    end)
    |> simulate()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, row}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, col}, acc ->
        Map.put(acc, {row, col}, String.to_integer(value))
      end)
    end)
    |> find_sync(1)
    |> then(fn {_, x} -> x end)

  end
end
