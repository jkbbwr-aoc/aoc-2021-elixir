defmodule AdventOfCode.Day15 do
  def get_neighbours(grid, {{x, y}, _v}) do
    [
      {{x + 1, y}, Map.get(grid, {x + 1, y}, 10000)},
      {{x - 1, y}, Map.get(grid, {x - 1, y}, 10000)},
      {{x, y + 1}, Map.get(grid, {x, y + 1}, 10000)},
      {{x, y - 1}, Map.get(grid, {x, y - 1}, 10000)}
    ]
  end

  def build_graph(grid) do
    Graph.new(vertex_identifier: fn v -> v end)
    |> then(fn g ->
      Enum.reduce(grid, g, fn {{x, y}, _val} = v, g ->
        Enum.reduce(get_neighbours(grid, v), g, fn {{dx, dy}, cost}, acc ->
          Graph.add_edge(acc, {x, y}, {dx, dy}, weight: cost)
        end)
      end)
    end)
  end

  def grow_x(grid, x) do
    targets = for y <- 0..x, x <- (x + 1)..((x + 1) * 5 - 1), do: {x, y}

    Enum.reduce(targets, grid, fn {x, y}, acc ->
      new =
        case Map.get(acc, {x - 10, y}) do
          nil -> raise "Fuck"
          9 -> 1
          n -> n + 1
        end

      Map.put(acc, {x, y}, new)
    end)
  end

  def grow_y(grid, y) do
    targets = for x <- 0..((y + 1) * 5 - 1), y <- (y + 1)..((y + 1) * 5 - 1), do: {x, y}

    Enum.reduce(targets, grid, fn {x, y}, acc ->
      new =
        case Map.get(acc, {x, y - 10}) do
          nil -> raise "Fuck"
          9 -> 1
          n -> n + 1
        end

      Map.put(acc, {x, y}, new)
    end)
  end

  def part1(args) do
    grid =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> line |> String.graphemes() |> Enum.with_index() end)
      |> Enum.with_index()
      |> Enum.reduce([], fn {elems, row}, acc ->
        Enum.reduce(elems, acc, fn {value, col}, acc ->
          [{{row, col}, String.to_integer(value)} | acc]
        end)
      end)
      |> Enum.into(%{})

    {{x, y}, _} = Enum.max(grid)

    build_graph(grid)
    |> Graph.Pathfinding.dijkstra({0, 0}, {x, y})
    |> Enum.reduce(0, fn key, acc -> acc + Map.get(grid, key) end)
    |> then(fn x -> x - 1 end)
  end

  def part2(args) do
    grid =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> line |> String.graphemes() |> Enum.with_index() end)
      |> Enum.with_index()
      |> Enum.reduce([], fn {elems, row}, acc ->
        Enum.reduce(elems, acc, fn {value, col}, acc ->
          [{{row, col}, String.to_integer(value)} | acc]
        end)
      end)
      |> Enum.into(%{})

    {{x, y}, _} = Enum.max(grid)

    grid =
      grid
      |> grow_x(x)
      |> grow_y(y)

    {{x, y}, _} = Enum.max(grid)

    build_graph(grid)
    |> Graph.Pathfinding.dijkstra({0, 0}, {x, y})
    |> Enum.reduce(-1, fn key, acc -> acc + Map.get(grid, key) end)
  end
end
