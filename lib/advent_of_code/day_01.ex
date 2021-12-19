defmodule AdventOfCode.Day01 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(
      0,
      fn
        [x, y], acc when x > y -> acc
        [x, y], acc when x < y -> acc + 1
      end
    )
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> [Enum.sum(x), Enum.sum(y)] end)
    |> Enum.reduce(
      0,
      fn
        [x, y], acc when x >= y -> acc
        [x, y], acc when x < y -> acc + 1
      end
    )
  end
end
