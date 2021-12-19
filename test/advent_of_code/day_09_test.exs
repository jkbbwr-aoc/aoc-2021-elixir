defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Day09

  test "part1" do
    input = AdventOfCode.Input.get!(9, 2021)
    result = part1(input)

    assert result == 524
  end

  test "part2" do
    input = AdventOfCode.Input.get!(9, 2021)
    result = part2(input)

    assert result == 1_235_430
  end
end
