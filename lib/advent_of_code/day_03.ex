defmodule AdventOfCode.Day03 do
  def read_energy(input, func) do
    input
    |> Enum.zip_with(fn x -> x end)
    |> Enum.map_join(fn x ->
      x
      |> Enum.frequencies()
      |> then(&func.(&1))
      |> elem(0)
    end)
    |> String.to_integer(2)
  end

  def read_gas(x, _y \\ 0, gas)

  def read_gas([x], _y, _gas) do
    x
    |> Enum.join()
    |> String.to_integer(2)
  end

  def read_gas(input, index, gas) do
    freq =
      input
      |> Enum.map(&Enum.at(&1, index))
      |> Enum.frequencies()

    x = Map.get(freq, "0", 0)
    y = Map.get(freq, "1", 0)

    case gas do
      :o2 when x == y ->
        read_gas(Enum.filter(input, fn x -> Enum.at(x, index) == "1" end), index + 1, gas)

      :o2 when x < y ->
        read_gas(Enum.filter(input, fn x -> Enum.at(x, index) == "1" end), index + 1, gas)

      :o2 when x > y ->
        read_gas(Enum.filter(input, fn x -> Enum.at(x, index) == "0" end), index + 1, gas)

      :co2 when x == y ->
        read_gas(Enum.filter(input, fn x -> Enum.at(x, index) == "0" end), index + 1, gas)

      :co2 when x < y ->
        read_gas(Enum.filter(input, fn x -> Enum.at(x, index) == "0" end), index + 1, gas)

      :co2 when x > y ->
        read_gas(Enum.filter(input, fn x -> Enum.at(x, index) == "1" end), index + 1, gas)
    end
  end

  def part1(args) do
    input =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    max =
      input
      |> read_energy(fn x -> Enum.max_by(x, &elem(&1, 1)) end)

    min =
      input
      |> read_energy(fn x -> Enum.min_by(x, &elem(&1, 1)) end)

    max * min
  end

  def part2(args) do
    input =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    o2 = read_gas(input, :o2)
    co2 = read_gas(input, :co2)
    o2 * co2
  end
end
