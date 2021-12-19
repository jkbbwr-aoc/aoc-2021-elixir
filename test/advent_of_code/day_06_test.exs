defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  test "part1" do
    input = AdventOfCode.Input.get!(6, 2021)
    result = part1(input)

    assert result == 376_194
  end

  test "part2" do
    input = AdventOfCode.Input.get!(6, 2021)
    result = part2(input)

    assert result == 1_693_022_481_538
  end
end
