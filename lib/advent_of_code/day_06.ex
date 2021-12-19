defmodule AdventOfCode.Day06 do
  def step(fish) do
    Enum.reduce(fish, %{}, fn
      {0, v}, acc ->
        acc
        |> Map.update(6, v, &(&1 + v))
        |> Map.update(8, v, &(&1 + v))

      {n, v}, acc ->
        Map.update(acc, n - 1, v, &(&1 + v))
    end)
  end

  def part1(args) do
    args
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
    |> then(fn fish ->
      Enum.reduce(1..80, fish, fn _x, acc -> step(acc) end)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  defmodule SumSeries do
    def of(0, n), do: n
    def of(c, n), do: of(c - 1, n + (n - 1))
  end

  def part2(args) do
    args
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
    |> then(fn fish ->
      Enum.reduce(1..256, fish, fn _x, acc -> step(acc) end)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
