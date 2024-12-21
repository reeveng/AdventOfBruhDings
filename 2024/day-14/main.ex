require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(fn something ->
    [_, x, y, _, vx, vy] = something |> String.split(["=", ",", " "])

    [x, y, vx, vy] = [x, y, vx, vy] |> Enum.map(&String.to_integer/1)
    [{y, x}, {vy, vx}]
  end)

# IO.inspect(input, charlists: :as_lists, limit: :infinity)

# part 1

defmodule Sims do
  def move_robot([{y, x}, {vy, vx}], max_width, max_height) do
    new_y = rem(max_height + y + vy, max_height)
    new_x = rem(max_width + x + vx, max_width)

    [{new_y, new_x}, {vy, vx}]
  end

  def robots_by_quadrant(robots, max_width, max_height) do
    quadrants = {0, 0, 0, 0}

    robots
    |> Enum.reduce(quadrants, fn [{y, x}, {_vy, _vx}], {first, second, third, fourth} ->
      middle_x = floor(max_width / 2)
      middle_y = floor(max_height / 2)

      left = x <= middle_x
      top = y <= middle_y
      bottom = y >= middle_y
      right = x >= middle_x

      cond do
        x == middle_x || y == middle_y ->
          {first, second, third, fourth}

        left && top ->
          {first + 1, second, third, fourth}

        right && top ->
          {first, second + 1, third, fourth}

        left && bottom ->
          {first, second, third + 1, fourth}

        right && bottom ->
          {first, second, third, fourth + 1}

        true ->
          {first, second, third, fourth}
      end
    end)
  end

  def print_board(points, max_width, max_height) do
    board =
      Enum.map(1..max_height, fn _item ->
        Enum.map(1..max_width, fn _item ->
          "."
        end)
      end)

    board =
      Enum.reduce(points, board, fn
        {y, x}, board ->
          board_value = get_board_value(board, y, x)

          board_value =
            case board_value do
              "." -> 0 + 1
              _ -> board_value + 1
            end

          update_board(board, y, x, board_value)
      end)

    print(board)
  end

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

  def print(board) do
    board
    |> Enum.map(fn row -> row |> Enum.join() end)
    |> Enum.each(fn row ->
      IO.inspect(row, charlists: :as_lists, limit: :infinity)
    end)
  end

  def update_board(board, y, x, value) do
    if(y >= 0 and x >= 0) do
      List.update_at(board, y, fn row ->
        List.update_at(row, x, fn _ -> value end)
      end)
    else
      board
    end
  end

  def solution(robots, time, max_width, max_height) do
    robots =
      Enum.reduce(1..time, robots, fn seconds, robots ->
        IO.inspect(seconds)
        Enum.map(robots, fn [possy, _speedy] -> possy end) |> print_board(max_width, max_height)

        robots
        |> Enum.map(fn robot -> move_robot(robot, max_width, max_height) end)
      end)

    robots_by_quadrant = robots_by_quadrant(robots, max_width, max_height)

    # _safety_factor
    robots_by_quadrant
    |> Tuple.to_list()
    |> Enum.reduce(1, fn value, acc -> value * acc end)
  end

  def solution_v2(robots, time, max_width, max_height) do
    Enum.reduce(1..time, robots, fn seconds, robots ->
      IO.inspect(seconds)
      Enum.map(robots, fn [possy, _speedy] -> possy end) |> print_board(max_width, max_height)

      robots
      |> Enum.map(fn robot -> move_robot(robot, max_width, max_height) end)
    end)
  end
end

time = 100
max_width = 101
max_height = 103

# max_width = 11
# max_height = 7

Sims.solution(input, time, max_width, max_height) |> IO.inspect()

# part 2

time = 10000

Sims.solution(input, time, max_width, max_height) |> IO.inspect()
