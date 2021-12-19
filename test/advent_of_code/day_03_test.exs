defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  test "part1" do
    input = AdventOfCode.Input.get!(3, 2021)
    result = part1(input)

    assert result == 3_309_596
  end

  test "part2" do
    input = AdventOfCode.Input.get!(3, 2021)
    result = part2(input)

    assert result == 2_981_085
  end
end
