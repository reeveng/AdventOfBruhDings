require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input =
  input
  |> String.split()
  |> Enum.map(fn row ->
    row
    |> String.split("", trim: true)
    |> Enum.map(fn item ->
      item
      |> String.to_integer()
    end)
  end)

IO.inspect(input, charlists: :as_lists, limit: :infinity)

# part 1

defmodule Trial do
  @doc """
  ## Examples

  Expected use case:
  ```elixir
  iex> Trial.all_start_positions([[1, 2, 0]])
  [{0,2}]
  ```
  """
  def all_start_positions(board) do
    Enum.with_index(board)
    |> Enum.reduce([], fn {row, y}, acc ->
      Enum.with_index(row)
      |> Enum.reduce(acc, fn {value, x}, acc ->
        if(value == 0) do
          acc ++ [{y, x}]
        else
          acc
        end
      end)
    end)
  end

  def up(y, x), do: {y - 1, x}
  def down(y, x), do: {y + 1, x}
  def left(y, x), do: {y, x - 1}
  def right(y, x), do: {y, x + 1}

  def get_board_value(board, y, x) do
    row = List.first(board)

    if(y >= 0 && y < length(board) && x < length(row) && x >= 0) do
      row = Enum.at(board, y)

      if row do
        Enum.at(row, x)
      else
        nil
      end
    end
  end

  def is_next_in_path?({y, x}, {by, bx}, board) do
    bruh = get_board_value(board, y, x)
    other_bruh = get_board_value(board, by, bx)
    IO.inspect(bruh, label: "bruh")
    IO.inspect(other_bruh, label: "other bruh")
    (bruh != nil && other_bruh != nil && bruh + 1 == other_bruh) |> IO.inspect(label: "res")
  end

  def possible_moves({y, x}, board) do
    [&up/2, &down/2, &left/2, &right/2]
    |> Enum.map(fn function ->
      function.(y, x)
    end)
    |> Enum.filter(fn item ->
      case item do
        nil -> false
        {_, _} -> is_next_in_path?({y, x}, item, board)
        _ -> false
      end
    end)
  end

  def distinct_end_positions(positions, board), do: distinct_end_positions(positions, board, [])

  def distinct_end_positions([], _board, end_positions_reachable) do
    end_positions_reachable
  end

  def distinct_end_positions([{y, x}], board, end_positions_reachable) do
    if(get_board_value(board, y, x) == 9) do
      end_positions_reachable ++ [{y, x}]
    else
      positions = possible_moves({y, x}, board)

      end_positions_reachable ++ distinct_end_positions(positions, board, end_positions_reachable)
    end
  end

  def distinct_end_positions([item | positions], board, end_positions_reachable) do
    (distinct_end_positions([item], board, end_positions_reachable) ++
       distinct_end_positions(positions, board, end_positions_reachable))
    |> Enum.uniq()
  end

  def solution(board) do
    start_positions = all_start_positions(board)

    all_distinct_end_positions =
      start_positions
      |> Enum.map(fn start_pos ->
        length(distinct_end_positions([start_pos], board))
      end)
      |> Enum.sum()

    all_distinct_end_positions
  end
end

IO.inspect(Trial.solution(input))

# part 2

defmodule TrialV2 do
  @doc """
  ## Examples

  Expected use case:
  ```elixir
  iex> Trial.all_start_positions([[1, 2, 0]])
  [{0,2}]
  ```
  """
  def all_start_positions(board) do
    Enum.with_index(board)
    |> Enum.reduce([], fn {row, y}, acc ->
      Enum.with_index(row)
      |> Enum.reduce(acc, fn {value, x}, acc ->
        if(value == 0) do
          acc ++ [{y, x}]
        else
          acc
        end
      end)
    end)
  end

  def up(y, x), do: {y - 1, x}
  def down(y, x), do: {y + 1, x}
  def left(y, x), do: {y, x - 1}
  def right(y, x), do: {y, x + 1}

  def get_board_value(board, y, x) do
    row = List.first(board)

    if(y >= 0 && y < length(board) && x < length(row) && x >= 0) do
      row = Enum.at(board, y)

      if row do
        Enum.at(row, x)
      else
        nil
      end
    end
  end

  def is_next_in_path?({y, x}, {by, bx}, board) do
    bruh = get_board_value(board, y, x)
    other_bruh = get_board_value(board, by, bx)
    IO.inspect(bruh, label: "bruh")
    IO.inspect(other_bruh, label: "other bruh")
    (bruh != nil && other_bruh != nil && bruh + 1 == other_bruh) |> IO.inspect(label: "res")
  end

  def possible_moves({y, x}, board) do
    [&up/2, &down/2, &left/2, &right/2]
    |> Enum.map(fn function ->
      function.(y, x)
    end)
    |> Enum.filter(fn item ->
      case item do
        nil -> false
        {_, _} -> is_next_in_path?({y, x}, item, board)
        _ -> false
      end
    end)
  end

  def score_trial(positions, board), do: score_trial(positions, board, [])

  def score_trial([], _board, score) do
    score
  end

  def score_trial([{y, x}], board, score) do
    if(get_board_value(board, y, x) == 9) do
      score ++ [{y, x}]
    else
      positions = possible_moves({y, x}, board)

      score ++ score_trial(positions, board, score)
    end
  end

  def score_trial([item | positions], board, score) do
    score_trial([item], board, score) ++
      score_trial(positions, board, score)
  end

  def solution(board) do
    start_positions = all_start_positions(board)

    all_distinct_end_positions =
      start_positions
      |> Enum.map(fn start_pos ->
        length(score_trial([start_pos], board))
      end)
      |> Enum.sum()

    all_distinct_end_positions
  end
end

IO.inspect(TrialV2.solution(input))
