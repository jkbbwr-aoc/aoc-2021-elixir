defmodule AdventOfCode.Day07 do
  def solve_simple(crabs) do
    goal =
      crabs
      |> Enum.sort()
      |> Enum.at(trunc(Enum.count(crabs) / 2))

    Enum.reduce(crabs, 0, fn x, acc -> acc + (max(goal, x) - min(goal, x)) end)
  end

  def solve_complex(crabs) do
    mean = Enum.sum(crabs) / length(crabs)
    upper = mean |> floor
    lower = mean |> ceil

    gauss = fn x -> x * (x + 1) / 2 end

    min(
      Enum.reduce(crabs, 0, fn x, acc -> gauss.(abs(upper - x)) + acc end),
      Enum.reduce(crabs, 0, fn x, acc -> gauss.(abs(lower - x)) + acc end)
    )
    |> trunc
  end

  def part1(args) do
    args
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> solve_simple
  end

  def part2(args) do
    args
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> solve_complex
  end
end
