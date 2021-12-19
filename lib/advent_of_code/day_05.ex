defmodule AdventOfCode.Day05 do
  defp plot([x, y1, x, y2], map) do
    Enum.reduce(y1..y2, map, fn y, acc -> Map.update(acc, {x, y}, 1, &(&1 + 1)) end)
  end

  defp plot([x1, y, x2, y], map) do
    Enum.reduce(x1..x2, map, fn x, acc -> Map.update(acc, {x, y}, 1, &(&1 + 1)) end)
  end

  defp plot([x1, y1, x2, y2], map) when x1 - x2 == y1 - y2 do
    min_x = min(x1, x2)
    min_y = min(y1, y2)

    Enum.reduce(
      0..abs(x1 - x2),
      map,
      fn x, acc ->
        Map.update(acc, {min_x + x, min_y + x}, 1, &(&1 + 1))
      end
    )
  end

  defp plot([x1, y1, x2, y2], map) when x1 - x2 == y2 - y1 do
    min_x = min(x1, x2)
    max_y = max(y1, y2)

    Enum.reduce(
      0..abs(x1 - x2),
      map,
      fn x, acc ->
        Map.update(acc, {min_x + x, max_y - x}, 1, &(&1 + 1))
      end
    )
  end

  def part1(args) do
    args
    |> String.split([" -> ", ",", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(4, 4, :discard)
    |> Enum.filter(fn [x1, y1, x2, y2] -> x1 == x2 or y1 == y2 end)
    |> Enum.reduce(%{}, &plot/2)
    |> Enum.count(fn {_, c} -> c >= 2 end)
  end

  def part2(args) do
    args
    |> String.split([" -> ", ",", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(4, 4, :discard)
    |> Enum.reduce(%{}, &plot/2)
    |> Enum.count(fn {_, c} -> c >= 2 end)
  end
end
