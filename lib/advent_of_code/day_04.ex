defmodule AdventOfCode.Day04 do
  def parse(input) do
    [calls | boards] = String.split(input, "\n\n", trim: true)
    {parse_calls(calls), Enum.map(boards, &parse_board/1)}
  end

  def parse_calls(calls) do
    calls
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def parse_board(input) do
    board =
      input
      |> String.replace("\n", " ")
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    {
      Enum.chunk_every(board, 5),
      for i <- 0..4 do
        board
        |> Enum.drop(i)
        |> Enum.take_every(5)
      end
    }
  end

  def score_board({rows, _columns}, calls) do
    rows
    |> List.flatten()
    |> Enum.filter(fn x ->
      !(x in calls)
    end)
    |> Enum.sum()
  end

  def check_win({rows, columns}, calls) do
    win =
      Enum.any?(
        rows,
        fn row -> Enum.all?(row, &(&1 in calls)) end
      ) ||
        Enum.any?(
          columns,
          fn col -> Enum.all?(col, &(&1 in calls)) end
        )

    if win do
      score_board({rows, columns}, calls)
    else
      :no_win
    end
  end

  def play_til_first_win(calls, boards, rounds \\ 1)

  def play_til_first_win(calls, boards, rounds) do
    round = Enum.take(calls, rounds)

    winner =
      boards
      |> Enum.map(&check_win(&1, round))
      |> Enum.find(&(&1 != :no_win))

    case winner do
      nil ->
        play_til_first_win(calls, boards, rounds + 1)

      x when is_integer(x) ->
        {x, List.last(round)}
    end
  end

  def play_til_last_win(calls, boards, rounds \\ 1)

  def play_til_last_win(calls, [board], rounds) do
    round = Enum.take(calls, rounds)

    case check_win(board, round) do
      :no_win -> play_til_last_win(calls, [board], rounds + 1)
      x -> {x, List.last(round)}
    end
  end

  def play_til_last_win(calls, boards, rounds) do
    round = Enum.take(calls, rounds)

    boards =
      boards
      |> Enum.filter(&(check_win(&1, round) == :no_win))

    play_til_last_win(calls, boards, rounds + 1)
  end

  def part1(args) do
    [calls | boards] = String.split(args, "\n\n", trim: true)
    calls = parse_calls(calls)
    boards = Enum.map(boards, &parse_board/1)

    {score, num} = play_til_first_win(calls, boards)
    score * num
  end

  def part2(args) do
    [calls | boards] = String.split(args, "\n\n", trim: true)
    calls = parse_calls(calls)
    boards = Enum.map(boards, &parse_board/1)

    {score, num} = play_til_last_win(calls, boards)
    score * num
  end
end
