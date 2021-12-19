defmodule AdventOfCode.Day14 do
  def step(polymar, pairs_count, _, 0) do
    count_chars(pairs_count, polymar) |> subtract_quantity()
  end

  def step(polymar, pairs_count, pairs, n) do
    step(polymar, update_count(pairs_count, pairs), pairs, n - 1)
  end

  def subtract_quantity(char_counts) do
    char_counts |> Map.values() |> Enum.min_max() |> then(fn {min, max} -> max - min end)
  end

  def update_count(pairs_count, pairs) do
    pairs_count
    |> Enum.reduce(%{}, fn {pair, count}, acc ->
      [first, last] = String.graphemes(pair)

      Map.update(acc, first <> Map.get(pairs, pair), count, fn value -> value + count end)
      |> Map.update(Map.get(pairs, pair) <> last, count, fn value -> value + count end)
    end)
  end

  def count(polymar) do
    polymar
    |> String.graphemes()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&Enum.join/1)
    |> Enum.frequencies()
  end

  def count_chars(pairs_count, polymar) do
    p = polymar |> String.graphemes() |> Enum.at(-1)
    map = %{p => 1}

    Enum.reduce(pairs_count, map, fn {pair, count}, acc ->
      Map.update(acc, String.graphemes(pair) |> Enum.at(0), count, fn v -> v + count end)
    end)
  end

  def parse([template, pairs]) do
    {
      template,
      pairs
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.split(&1, " -> ", trim: true) |> List.to_tuple()))
      |> Map.new()
    }
  end

  def part1(args) do
    args
    |> String.split("\n\n", trim: true)
    |> parse()
    |> then(fn {polymar, pairs} -> step(polymar, count(polymar), pairs, 10) end)
  end

  def part2(args) do
    args
    |> String.split("\n\n", trim: true)
    |> parse()
    |> then(fn {polymar, pairs} -> step(polymar, count(polymar), pairs, 40) end)
  end
end
