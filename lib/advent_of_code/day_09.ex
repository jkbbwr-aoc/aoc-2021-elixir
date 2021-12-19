defmodule AdventOfCode.Day09 do
  def plot_line(line, acc) do
    {grid, {_x, y}} =
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(acc, &plot/2)

    {grid, {0, y + 1}}
  end

  def plot(elem, {grid, {x, y}}) do
    {Map.put(grid, {x, y}, elem), {x + 1, y}}
  end

  def is_low_point({x, y} = pos, grid) do
    pos = Map.get(grid, pos)

    Enum.all?(
      [
        Map.get(grid, {x, y - 1}, 9),
        Map.get(grid, {x, y + 1}, 9),
        Map.get(grid, {x - 1, y}, 9),
        Map.get(grid, {x + 1, y}, 9)
      ],
      &(pos < &1)
    )
  end

  def valid_neighbours({x, y}, grid) do
    Enum.filter(
      [
        {x, y - 1},
        {x, y + 1},
        {x - 1, y},
        {x + 1, y}
      ],
      &(Map.get(grid, &1, 9) != 9)
    )
  end

  def walk_basin(grid) do
    # Grab all locations that are not 9.
    lower = Map.keys(grid) |> Enum.filter(fn x -> Map.get(grid, x) != 9 end)

    {_visited, sizes} =
      Enum.reduce(lower, {MapSet.new(), []}, fn pos, {visited, sizes} ->
        case walk([pos], grid, visited, 0) do
          {visited, 1} -> {visited, sizes}
          {visited, size} -> {visited, [size | sizes]}
        end
      end)

    sizes |> Enum.sort(:desc) |> Enum.take(3) |> Enum.reduce(&(&1 * &2))
  end

  def walk([], _grid, visited, size), do: {visited, size}

  def walk([pos | queue], grid, visited, size) do
    visited = MapSet.put(visited, pos)
    size = size + 1
    queue = (queue ++ valid_neighbours(pos, grid)) |> Enum.reject(&MapSet.member?(visited, &1))

    walk(
      queue,
      grid,
      visited,
      size
    )
  end

  def part1(args) do
    {grid, _pos} =
      args
      |> String.split("\n", trim: true)
      |> Enum.reduce({%{}, {0, 0}}, &plot_line/2)

    grid
    |> Map.keys()
    |> Enum.filter(fn x -> is_low_point(x, grid) end)
    |> Enum.reduce(0, fn pos, acc -> acc + (1 + Map.get(grid, pos)) end)
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.reduce({%{}, {0, 0}}, &plot_line/2)
    |> then(fn {grid, _} -> walk_basin(grid) end)
  end
end
