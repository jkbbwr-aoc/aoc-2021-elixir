defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  test "part1" do
    input = AdventOfCode.Input.get!(7, 2021)
    result = part1(input)

    assert result == 349_769
  end

  test "part2" do
    input = AdventOfCode.Input.get!(7, 2021)
    result = part2(input)

    assert result == 99_540_554
  end
end
