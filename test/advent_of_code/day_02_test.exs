defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  test "part1" do
    input = AdventOfCode.Input.get!(2, 2021)
    result = part1(input)

    assert result == 1_427_868
  end

  test "part2" do
    input = AdventOfCode.Input.get!(2, 2021)
    result = part2(input)

    assert result == 1_568_138_742
  end
end
