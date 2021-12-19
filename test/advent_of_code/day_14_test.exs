defmodule AdventOfCode.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Day14

  test "part1" do
    input = AdventOfCode.Input.get!(14, 2021)
    result = part1(input)

    assert result == 2375
  end

  test "part2" do
    input = AdventOfCode.Input.get!(14, 2021)
    result = part2(input)

    assert result == 1976896901756
  end
end
