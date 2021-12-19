defmodule AdventOfCode.Day08 do
  def solve({wiring, number}) do
    # This one is a bit of a shitter.

    one = Enum.find(wiring, &(MapSet.size(&1) == 2))
    four = Enum.find(wiring, &(MapSet.size(&1) == 4))
    seven = Enum.find(wiring, &(MapSet.size(&1) == 3))
    eight = Enum.find(wiring, &(MapSet.size(&1) == 7))
    zero_six_nine = Enum.filter(wiring, &(MapSet.size(&1) == 6))
    two_three_five = Enum.filter(wiring, &(MapSet.size(&1) == 5))

    two =
      Enum.find(
        two_three_five,
        fn two ->
          MapSet.union(two, four)
          |> MapSet.size() == 7
        end
      )

    three =
      Enum.find(
        two_three_five,
        fn three ->
          MapSet.union(three, one)
          |> MapSet.size() == 5
        end
      )

    [five] =
      two_three_five
      |> List.delete(two)
      |> List.delete(three)

    nine =
      Enum.find(
        zero_six_nine,
        fn nine ->
          MapSet.union(nine, four)
          |> MapSet.size() == 6
        end
      )

    zero_six_nine =
      zero_six_nine
      |> List.delete(nine)

    zero =
      Enum.find(
        zero_six_nine,
        fn a ->
          MapSet.intersection(a, one)
          |> MapSet.size() == 2
        end
      )

    [six] =
      zero_six_nine
      |> List.delete(nine)
      |> List.delete(zero)

    known = %{
      zero => "0",
      one => "1",
      two => "2",
      three => "3",
      four => "4",
      five => "5",
      six => "6",
      seven => "7",
      eight => "8",
      nine => "9"
    }

    Enum.map_join(
      number,
      fn x ->
        Map.get(known, x)
      end
    )
    |> String.to_integer()
  end

  def parse(line) do
    [head, tail] = String.split(line, " | ", trim: true)
    {parse_part(head), parse_part(tail)}
  end

  def parse_part(part) do
    part
    |> String.split(" ")
    |> Enum.map(fn chunk ->
      chunk
      |> String.graphemes()
      |> Enum.sort()
      |> MapSet.new()
    end)
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" | ")
      |> List.last()
      |> String.split(" ")
    end)
    |> List.flatten()
    |> Enum.count(fn x ->
      String.length(x) in [2, 3, 4, 7]
    end)
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.reduce(0, &(&2 + solve(&1)))
  end
end
