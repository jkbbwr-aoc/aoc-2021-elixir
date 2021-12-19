defmodule AdventOfCode.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Day16

  test "part1" do
    input = AdventOfCode.Input.get!(16, 2021)
    result = part1(input)

    assert result
  end

  test "part2" do
    input = AdventOfCode.Input.get!(16, 2021)
    result = part2(input)

    assert result
  end
end
