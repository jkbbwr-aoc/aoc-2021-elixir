defmodule AdventOfCode.Day10 do
  def invert("("), do: ")"
  def invert("{"), do: "}"
  def invert("<"), do: ">"
  def invert("["), do: "]"

  @spec validate(String.t()) :: {:invalid, String.t(), String.t()} | any
  def validate(input) do
    Enum.reduce_while(input, [], fn
      next, stack when next in ["[", "(", "<", "{"] -> {:cont, [next | stack]}
      next, [top | rest] when next == "]" and top == "[" -> {:cont, rest}
      next, [top | rest] when next == ")" and top == "(" -> {:cont, rest}
      next, [top | rest] when next == ">" and top == "<" -> {:cont, rest}
      next, [top | rest] when next == "}" and top == "{" -> {:cont, rest}
      next, [top | _rest] -> {:halt, {:invalid, invert(top), next}}
    end)
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&validate/1)
    |> Enum.filter(fn
      {:invalid, _, _} -> true
      _ -> false
    end)
    |> Enum.reduce(0, fn
      {:invalid, _, ")"}, acc -> acc + 3
      {:invalid, _, "]"}, acc -> acc + 57
      {:invalid, _, "}"}, acc -> acc + 1197
      {:invalid, _, ">"}, acc -> acc + 25_137
    end)
  end

  # its easy, fuck you
  def replace(input) do
    input
    |> String.replace("()", "")
    |> String.replace("[]", "")
    |> String.replace("{}", "")
    |> String.replace("<>", "")
  end

  @spec complete([String.t()]) :: [String.t()]
  def complete(input) do
    forever = Stream.repeatedly(fn -> 1 end)

    Enum.reduce_while(forever, List.to_string(input), fn _, acc ->
      reduction = replace(acc)

      if reduction == acc do
        {:halt, acc}
      else
        {:cont, reduction}
      end
    end)
    |> String.graphemes()
    |> Enum.map(&invert/1)
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&validate/1)
    |> Enum.reject(fn
      {:invalid, _, _} -> true
      _ -> false
    end)
    |> Enum.map(fn x ->
      x
      |> complete
      |> Enum.reduce(0, fn
        ")", acc -> acc * 5 + 1
        "]", acc -> acc * 5 + 2
        "}", acc -> acc * 5 + 3
        ">", acc -> acc * 5 + 4
      end)
    end)
    |> Enum.sort()
    |> then(fn x -> Enum.at(x, div(length(x), 2)) end)
  end
end
