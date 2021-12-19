defmodule AdventOfCode.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Day13

  test "part1" do
    input = AdventOfCode.Input.get!(13, 2021)
    result = part1(input)

    assert result == 724
  end

  test "part2" do
    input = AdventOfCode.Input.get!(13, 2021)
    result = part2(input)

    assert result == " ██  ███    ██ ███  ████ ███  █  █ █   \n█  █ █  █    █ █  █ █    █  █ █  █ █   \n█    █  █    █ ███  ███  █  █ █  █ █   \n█    ███     █ █  █ █    ███  █  █ █   \n█  █ █    █  █ █  █ █    █ █  █  █ █   \n ██  █     ██  ███  ████ █  █  ██  ████\n"
  end
end
