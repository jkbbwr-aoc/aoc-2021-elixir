defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  test "part1" do
    input = AdventOfCode.Input.get!(10, 2021)
    result = part1(input)

    assert result == 323_613
  end

  test "part2" do
    input = AdventOfCode.Input.get!(10, 2021)
    result = part2(input)

    assert result == 3_103_006_161
  end
end
