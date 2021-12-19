defmodule AdventOfCode.Day12 do
  def paths(_map, "end", _visited), do: [true]

  def paths(map, cave, visited) do
    if match?(<<c::8, _::binary>> when c in ?a..?z, cave) and cave in visited do
      []
    else
      Enum.flat_map(map[cave], fn c -> paths(map, c, [cave | visited]) end)
    end
  end

  def complex(_map, "end", _visited, _), do: [true]
  def complex(_map, "start", [_ | _], _), do: []

  def complex(map, cave, visited, twice) do
    cond do
      match?(<<c::8, _::binary>> when c in ?a..?z, cave) and cave in visited and twice ->
        []

      match?(<<c::8, _::binary>> when c in ?a..?z, cave) and cave in visited ->
        Enum.flat_map(map[cave], fn c -> complex(map, c, visited, true) end)

      true ->
        Enum.flat_map(map[cave], fn c -> complex(map, c, [cave | visited], twice) end)
    end
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.flat_map(fn line ->
      [l, r] = String.split(line, "-")
      [{l, r}, {r, l}]
    end)
    |> Enum.group_by(fn {node, _} -> node end, fn {_l, r} -> r end)
    |> paths("start", [])
    |> Enum.count()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.flat_map(fn line ->
      [l, r] = String.split(line, "-")
      [{l, r}, {r, l}]
    end)
    |> Enum.group_by(fn {node, _} -> node end, fn {_l, r} -> r end)
    |> complex("start", [], false)
    |> Enum.count()
  end
end
