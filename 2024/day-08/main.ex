require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input = input |> String.split()
input = input |> Enum.map(&String.split(&1, "", trim: true))

# IO.inspect(input,
#   limit: :infinity,
#   charlists: :as_lists
# )

# part 1

# defmodule Antidote do
#   def node_locations_on_map(board, coordinates_of_elements) do
#     y_length = length(board)
#     x_length = length(List.first(board))

#     Enum.map(coordinates_of_elements, fn coordinate ->
#       Enum.map(coordinates_of_elements, fn other_coordinate ->
#         if coordinate != other_coordinate do
#           {ay, ax} = coordinate
#           {by, bx} = other_coordinate

# [
#   {ay * 2 - by, ax * 2 - bx},
#   {by * 2 - ay, bx * 2 - ax}
# ]
#           |> Enum.filter(fn new_coord ->
#             {y, x} = new_coord

#             y < y_length &&
#               y >= 0 &&
#               x < x_length &&
#               x >= 0
#           end)
#         else
#           nil
#         end
#       end)
#     end)
#     |> List.flatten()
#     |> Enum.filter(fn bruh -> bruh end)
#     |> Enum.uniq()
#   end

#   def distance_between_points(a, b) do
#     {ay, ax} = a
#     {by, bx} = b

#     ((ay - by) ** 2 + (ax - bx) ** 2) ** 0.5
#   end

#   def create_elements_in_location_map(board) do
#     Enum.reduce(Enum.with_index(board), %{}, fn {row, y}, acc ->
#       Enum.reduce(Enum.with_index(row), acc, fn {elem, x}, acc ->
#         if elem != "." do
#           Map.update(acc, elem, [{y, x}], &(&1 ++ [{y, x}]))
#         else
#           acc
#         end
#       end)
#     end)
#   end

#   def solution(board) do
#     map_of_elements = create_elements_in_location_map(board)
#     elements = Map.to_list(map_of_elements)

#     IO.inspect(elements)

#     Enum.map(elements, fn
#       {_key, values} ->
#         node_locations_on_map(board, values)
#     end)
#     |> List.flatten()
#     |> Enum.uniq()
#   end
# end

# something = length(Antidote.solution(input))
# IO.inspect(something)

# part 2

defmodule AntidoteV2 do
  def node_locations_on_map(board, coordinates_of_elements) do
    y_length = length(board)
    x_length = length(List.first(board))

    Enum.map(coordinates_of_elements, fn coordinate ->
      Enum.map(coordinates_of_elements, fn other_coordinate ->
        if coordinate != other_coordinate do
          {ay, ax} = coordinate
          {by, bx} = other_coordinate

          dx = bx - ax
          dy = by - ay

          get_next_node([coordinate], {dy, dx}, {y_length, x_length})
          |> List.flatten()
          |> Enum.filter(fn new_coord ->
            {y, x} = new_coord

            y < y_length &&
              y >= 0 &&
              x < x_length &&
              x >= 0
          end)
        else
          nil
        end
      end)
    end)
    |> List.flatten()
    |> Enum.filter(fn bruh -> bruh end)
    |> Enum.uniq()
    |> Enum.sort()
  end

  def is_ok(coordinates, board_size) do
    if List.last(coordinates) do
      {y, x} = List.last(coordinates)
      {y_board, x_board} = board_size


      y < y_board and
        y >= 0 and
        x < x_board and
        x >= 0
    else
      true
    end
  end

  def get_next_node(coordinates, offset, board_size) do
    if is_ok(coordinates, board_size) do
      {y, x} = List.last(coordinates)
      {dy, dx} = offset

      get_next_node(coordinates ++ [{y + dy, x + dx}], offset, board_size)
    else
      coordinates
    end
  end

  def distance_between_points(a, b) do
    {ay, ax} = a
    {by, bx} = b

    ((ay - by) ** 2 + (ax - bx) ** 2) ** 0.5
  end

  def create_elements_in_location_map(board) do
    Enum.reduce(Enum.with_index(board), %{}, fn {row, y}, acc ->
      Enum.reduce(Enum.with_index(row), acc, fn {elem, x}, acc ->
        if elem != "." do
          Map.update(acc, elem, [{y, x}], &(&1 ++ [{y, x}]))
        else
          acc
        end
      end)
    end)
  end

  def solution(board) do
    map_of_elements = create_elements_in_location_map(board)
    elements = Map.to_list(map_of_elements)

    Enum.map(elements, fn
      {_key, values} ->
        node_locations_on_map(board, values)
    end)
    |> List.flatten()
    |> Enum.uniq()
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

  def print_board(board, points) do
    print(board)

    board =
      Enum.reduce(points, board, fn
        {y, x}, board ->
          update_board(board, y, x, "#")
      end)

    print(board)
  end
end

temp = AntidoteV2.solution(input)
something_else = length(temp)
IO.inspect(temp)
IO.inspect(something_else)
