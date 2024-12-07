require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input = input |> String.split() |> Enum.map(&String.split(&1, "", trim: true))

# part 1

# defmodule Move do
#   def count_x_on_board(board) do
#     Enum.map(board, fn row -> Enum.count(row, &(&1 == "X")) end) |> Enum.sum()
#   end

#   def find_guard(board) do
#     # returns position of the guard
#     y = Enum.find_index(board, &(&1 |> Enum.join("") |> String.contains?(["v", ">", "<", "^"])))

#     if(y) do
#       y_row = Enum.at(board, y)

#       x = Enum.find_index(y_row, &String.contains?(&1, ["v", ">", "<", "^"]))

#       {y, x}
#     else
#       nil
#     end
#   end

#   def print(board) do
#     board
#     |> Enum.map(fn row -> row |> Enum.join() end)
#     |> Enum.each(fn row ->
#       IO.inspect(row, charlists: :as_lists, limit: :infinity)
#     end)
#   end

#   def is_end(board) do
#     if !find_guard(board) do
#       print(board)
#       true
#     else
#       false
#     end
#   end

#   def keep_on_moving(board, count) do
#     if(!is_end(board)) do
#       {y, x} = find_guard(board)

#       board = next_move(board, y, x)

#       keep_on_moving(board, count + 1)
#     else
#       amount_of_x = count_x_on_board(board)

#       {count, amount_of_x}
#     end
#   end

#   def next_move(board, y, x) do
#     row = Enum.at(board, y)

#     current_value = Enum.at(row, x)

#     board =
#       case current_value do
#         "v" ->
#           board = update_board(board, y, x, "X")

#           try do
#             down(board, y, x)
#           rescue
#             _ ->
#               nil
#           end

#         "^" ->
#           board = update_board(board, y, x, "X")

#           try do
#             up(board, y, x)
#           rescue
#             _ ->
#               nil
#           end

#         ">" ->
#           board = update_board(board, y, x, "X")

#           try do
#             right(board, y, x)
#           rescue
#             _ ->
#               nil
#           end

#         "<" ->
#           board = update_board(board, y, x, "X")

#           try do
#             left(board, y, x)
#           rescue
#             _ ->
#               nil
#           end
#       end

#     board
#   end

#   def contains_obstruction(value) do
#     value == "#"
#   end

#   def get_board_value(board, y, x) do
#     row = Enum.at(board, y)

#     if row do
#       _next_value = Enum.at(row, x)
#     else
#       nil
#     end
#   end

#   # "^" up y-1,x
#   def up(board, y, x) do
#     next_value = get_board_value(board, y - 2, x)

#     board =
#       if contains_obstruction(next_value) do
#         update_board(board, y - 1, x, ">")
#       else
#         update_board(board, y - 1, x, "^")
#       end

#     board
#   end

#   def update_board(board, y, x, value) do
#     if(y >= 0 and x >= 0) do
#       List.update_at(board, y, fn row ->
#         List.update_at(row, x, fn _ -> value end)
#       end)
#     else
#       board
#     end
#   end

#   # "v" down y+1,x
#   def down(board, y, x) do
#     next_value = get_board_value(board, y + 2, x)

#     board =
#       if contains_obstruction(next_value) do
#         update_board(board, y + 1, x, "<")
#       else
#         update_board(board, y + 1, x, "v")
#       end

#     board
#   end

#   # "<" left y,x-1
#   def left(board, y, x) do
#     next_value = get_board_value(board, y, x - 2)

#     board =
#       if contains_obstruction(next_value) do
#         update_board(board, y, x - 1, "^")
#       else
#         update_board(board, y, x - 1, "<")
#       end

#     board
#   end

#   # ">" right y,x+1
#   def right(board, y, x) do
#     next_value = get_board_value(board, y, x + 2)

#     board =
#       if contains_obstruction(next_value) do
#         update_board(board, y, x + 1, "v")
#       else
#         update_board(board, y, x + 1, ">")
#       end

#     board
#   end
# end

# {count, amount_of_x} = Move.keep_on_moving(input, 0)

# IO.inspect(
#   "total positions moved: #{count}, total amount of different positions visited: #{amount_of_x}"
# )

# part 2

defmodule MoveV2 do
  def count_x_on_board(board) do
    Enum.map(board, fn row -> Enum.count(row, &(&1 == "X")) end) |> Enum.sum()
  end

  def find_guard(board) do
    y = Enum.find_index(board, &(&1 |> Enum.join("") |> String.contains?(["v", ">", "<", "^"])))

    if(y) do
      y_row = Enum.at(board, y)

      x = Enum.find_index(y_row, &String.contains?(&1, ["v", ">", "<", "^"]))

      {y, x}
    else
      nil
    end
  end

  def is_end(board, y, x) do
    !get_board_value(board, y, x)
  end

  def create_unique_name(direction, y, x) do
    "#{direction}-#{y}-#{x}"
  end

  def is_infinite_loop(visited, name) do
    MapSet.member?(visited, name)
  end

  def keep_on_moving(board) do
    visited = MapSet.new()
    {y, x} = find_guard(board)
    current_dir = get_guard(board, y, x)

    keep_on_moving(board, visited, {y, x}, current_dir)
  end

  def keep_on_moving(board, visited, current_pos, current_dir) do
    {y, x} = current_pos

    if(is_end(board, y, x)) do
      visited
    else
      # see if current position is included in visited
      unique_name = create_unique_name(current_dir, y, x)

      if is_infinite_loop(visited, unique_name) do
        "bruh"
      else
        {current_pos, current_dir} = find_next_move(board, current_dir, y, x)

        visited = MapSet.put(visited, unique_name)

        keep_on_moving(board, visited, current_pos, current_dir)
      end
    end
  end

  def find_next_move(board, current_dir, y, x) do
    current_pos = next_move(current_dir, y, x)

    if !is_safe(board, current_pos) do
      next_dir = rotate(current_dir)

      find_next_move(board, next_dir, y, x)
    else
      {current_pos, current_dir}
    end
  end

  def rotate(dir) do
    case dir do
      "^" -> ">"
      ">" -> "v"
      "v" -> "<"
      "<" -> "^"
    end
  end

  def is_safe(board, {y, x}) do
    !contains_obstruction(get_board_value(board, y, x))
  end

  def get_guard(board, y, x) do
    get_board_value(board, y, x)
  end

  def next_move(current_dir, y, x) do
    directions = %{
      "v" => &down/2,
      "^" => &up/2,
      ">" => &right/2,
      "<" => &left/2
    }

    _current_pos =
      try do
        Map.get(directions, current_dir, fn _, _ -> nil end).(y, x)
      rescue
        _ -> nil
      end
  end

  def print(board) do
    board
    |> Enum.map(fn row -> row |> Enum.join() end)
    |> Enum.each(fn row ->
      nil
      IO.inspect(row, charlists: :as_lists, limit: :infinity)
    end)
  end

  def contains_obstruction(value) do
    value == "#" || value == "O"
  end

  def get_board_value(board, y, x) do
    if(y >= 0 && x >= 0) do
      row = Enum.at(board, y)

      if row do
        Enum.at(row, x)
      else
        nil
      end
    end
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

  def up(y, x) do
    {y - 1, x}
  end

  def down(y, x) do
    {y + 1, x}
  end

  def left(y, x) do
    {y, x - 1}
  end

  def right(y, x) do
    {y, x + 1}
  end
end

# {time, _result} =
#   :timer.tc(fn ->
# IO.inspect("started getting all positions")

visited = MoveV2.keep_on_moving(input)

locations_to_check =
  MapSet.to_list(visited)
  |> Enum.map(fn elem ->
    [_dir, y, x] = String.split(elem, "-")
    y = String.to_integer(y)
    x = String.to_integer(x)
    {y, x}
  end)
  |> Enum.uniq()
  |> Enum.sort()

# IO.inspect(locations_to_check, charlists: :as_lists, limit: :infinity)

# IO.inspect("finished getting all positions")

{y_guard, x_guard} = MoveV2.find_guard(input)

total_count =
  locations_to_check
  |> Task.async_stream(
    fn {y, x} ->
      # IO.inspect("executing (#{y},#{x}) now, wait patiently!")

      current_value = MoveV2.get_board_value(input, y, x)
      is_guard_position = x == x_guard and y == y_guard

      if !is_guard_position and !MoveV2.contains_obstruction(current_value) do
        new_board = MoveV2.update_board(input, y, x, "O")

        possibly_bruh = MoveV2.keep_on_moving(new_board)

        if possibly_bruh == "bruh" do
          # IO.inspect("found infinite loop at: (#{y},#{x})!")
          1
        else
          0
        end
      else
        # IO.inspect("skipped (#{y},#{x})!")
        0
      end
    end,
    max_concurrency: System.schedulers_online(),
    timeout: 60 * 60 * 1000
  )
  |> Enum.reduce(0, fn
    {:ok, count}, acc -> acc + count
    # Handle errors if needed
    {:error, _reason}, acc -> acc
  end)

IO.inspect("total number of infinite loops: #{total_count}")
# end)

# IO.puts("Execution time: #{time} μs")
