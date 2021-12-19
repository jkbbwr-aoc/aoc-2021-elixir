defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11

  test "part1" do
    input = AdventOfCode.Input.get!(11, 2021)
    result = part1(input)

    assert result == 1702
  end

  test "part2" do
    input = AdventOfCode.Input.get!(11, 2021)
    result = part2(input)
    assert result == 251
  end
end
