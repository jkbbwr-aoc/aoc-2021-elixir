defmodule AdventOfCode.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Day12

  test "part1" do
    input = AdventOfCode.Input.get!(12, 2021)
    result = part1(input)

    assert result == 3410
  end

  test "part2" do
    input = AdventOfCode.Input.get!(12, 2021)
    result = part2(input)

    assert result == 98_796
  end
end
