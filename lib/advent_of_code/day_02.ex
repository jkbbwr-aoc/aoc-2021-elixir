defmodule AdventOfCode.Day02 do
  def parse("forward " <> x), do: {:forward, String.to_integer(x)}
  def parse("down " <> x), do: {:down, String.to_integer(x)}
  def parse("up " <> x), do: {:up, String.to_integer(x)}
  def parse(_), do: raise("Fucked direction")

  def run_simple(instructions) do
    Enum.reduce(
      instructions,
      {0, 0},
      fn
        {:forward, z}, {x, y} -> {x + z, y}
        {:up, z}, {x, y} -> {x, y - z}
        {:down, z}, {x, y} -> {x, y + z}
      end
    )
  end

  def run_complex(instructions) do
    Enum.reduce(
      instructions,
      {0, 0, 0},
      fn
        {:down, z}, {x, y, aim} -> {x, y, aim + z}
        {:up, z}, {x, y, aim} -> {x, y, aim - z}
        {:forward, z}, {x, y, aim} -> {x + z, y + aim * z, aim}
      end
    )
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> run_simple
    |> then(fn {x, y} -> x * y end)
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> run_complex
    |> then(fn {x, y, _z} -> x * y end)
  end
end
