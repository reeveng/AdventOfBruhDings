require File

file_paths = [
  {"input.test", 1206},
  {"input-1.test", 80},
  {"input-2.test", 436},
  {"input-3.test", 22}
]

# IO.inspect(input, charlists: :as_lists, limit: :infinity)

# part 1

defmodule Region do
  def parse_input(file_path) do
    if(!File.exists?(file_path)) do
      IO.puts("value_of_coord_1, this file doesn't exist")
    end

    {:ok, input} = File.read(file_path)

    input
    |> String.split()
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  def up({y, x}), do: {y - 1, x}
  def up_right({y, x}), do: {y - 1, x + 1}
  def up_left({y, x}), do: {y - 1, x - 1}
  def down({y, x}), do: {y + 1, x}
  def down_left({y, x}), do: {y + 1, x - 1}
  def down_right({y, x}), do: {y + 1, x + 1}
  def left({y, x}), do: {y, x - 1}
  def right({y, x}), do: {y, x + 1}

  def get_board_value(board, {y, x}) do
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

  def part_of_region?(coord_1, coord_2, board) do
    value_of_coord_1 = get_board_value(board, coord_1)
    value_of_coord_2 = get_board_value(board, coord_2)

    value_of_coord_1 != nil && value_of_coord_2 != nil && value_of_coord_1 == value_of_coord_2
  end

  def find_all_neighbours(coord, board, neighbours) do
    prev_total_length = MapSet.size(neighbours)

    new_neighbours =
      [&up/1, &down/1, &right/1, &left/1]
      |> Enum.map(& &1.(coord))
      |> Enum.filter(&part_of_region?(&1, coord, board))
      |> MapSet.new()

    neighbours = MapSet.union(neighbours, new_neighbours)

    total_neighbours = MapSet.size(neighbours)

    if(total_neighbours > prev_total_length) do
      Enum.reduce(new_neighbours, neighbours, fn neighbour, acc ->
        MapSet.union(acc, find_all_neighbours(neighbour, board, acc))
      end)
    else
      neighbours
    end
  end

  def region_selection(board) do
    Enum.reduce(Enum.with_index(board), [], fn {row, y}, acc ->
      Enum.reduce(Enum.with_index(row), acc, fn {_, x}, acc ->
        first_coord = {y, x}

        acc ++
          [find_all_neighbours(first_coord, board, MapSet.new([first_coord])) |> Enum.sort()]
      end)
    end)
    |> Enum.uniq()
  end

  def perimeter(list) do
    outside_elements =
      Enum.flat_map(list, fn coord ->
        [&up/1, &down/1, &right/1, &left/1]
        |> Enum.map(& &1.(coord))
        |> Enum.filter(&(!Enum.member?(list, &1)))
      end)

    length(outside_elements)
  end

  def perimeter_v2(list) do
    outside_elements =
      Enum.flat_map(list, fn coord ->
        [
          &up/1,
          &down/1,
          &right/1,
          &left/1,
          &up_right/1,
          &up_left/1,
          &down_right/1,
          &down_left/1
        ]
        |> Enum.map(& &1.(coord))
        |> Enum.filter(&(!Enum.member?(list, &1)))
      end)
      |> Enum.sort()

    # wtf is a corner in a grid?
    # usually a corner has 1 left|right and 1 bottom | top
    # 1 top/bottom and x sides which then becomes a U or a n thing

    # IO.inspect(outside_elements)

    count_corners(list)

    # lines = lines(outside_elements)

    # multipleInARow =
    #   MapSet.filter(lines, fn {_direction, values} ->
    #     length(values) > 1
    #   end)
    #   |> MapSet.to_list()

    # lines =
    #   Enum.reduce(multipleInARow, lines, fn {_direction, values}, lines ->
    #     values = Enum.sort(values)

    #     Enum.reduce(values, lines, fn coord, lines ->
    #       if List.first(values) != coord && List.last(values) != coord do
    #         lines =
    #           MapSet.delete(lines, {:x, [coord]})

    #         _lines = MapSet.delete(lines, {:y, [coord]})
    #       else
    #         lines
    #       end
    #     end)
    #   end)

    # 897186
    # real result here somewhere -----
    # 888361

    # MapSet.size(lines)
  end

  # def count_corners(list) do
  #   #   # visited = MapSet.new()
  #   #   # start_point = List.first(coord_options(visited, {List.first(outside), nil}, outside))

  #   #   # # IO.inspect(start_point)

  #   #   # find_next_coord(visited, start_point, outside, 1) |> IO.inspect()

  #   #   IO.inspect(list)
  #   Enum.reduce(list, 0, fn coord, corners ->
  #     direct_neighbour = find_direct_neighbours(coord, list)

  #     IO.inspect(coord)

  #     case corner?(direct_neighbour) do
  #       true -> corners + 1
  #       false -> corners
  #     end
  #   end)
  # end

  def corner?(neighbours) do
    diagonals = diagonals(neighbours)
    non_diagonals = not_diagonals(neighbours)

    IO.inspect(length(diagonals))
    IO.inspect(length(non_diagonals))
  end

  defp diagonals(list) do
    Enum.filter(list, fn direction ->
      direction in [:up_right, :up_left, :down_right, :down_left]
    end)
  end

  defp not_diagonals(list) do
    Enum.filter(list, fn direction ->
      direction in [:up, :down, :left, :right]
    end)
  end

  def find_direct_neighbours(coord, list) do
    [
      {&up/1, :up},
      {&down/1, :down},
      {&right/1, :right},
      {&left/1, :left},
      {&up_right/1, :up_right},
      {&up_left/1, :up_left},
      {&down_right/1, :down_right},
      {&down_left/1, :down_left}
    ]
    |> Enum.map(fn {func, dir} ->
      {func.(coord), dir}
    end)
    |> Enum.reject(fn {coord, _dir} ->
      coord not in list
    end)
  end

  def count_corners(region_positions) do
    Enum.reduce(region_positions, 0, fn position, found_corners ->
      neighbors = find_direct_neighbours(position, region_positions)

      [up, down, right, left, up_right, up_left, down_right, down_left] = neighbors

      temp_corners =
        cond do
          up and left and not up_left -> 1
          up and right and not up_right -> 1
          down and left and not down_left -> 1
          down and right and not down_right -> 1
          not up and not left -> 1
          not up and not right -> 1
          not down and not left -> 1
          not down and not right -> 1
          true -> 0
        end

      found_corners + temp_corners
    end)
  end

  # def opposite_direction(direction) do
  #   case direction do
  #     :up -> :down
  #     :right -> :left
  #     :down -> :up
  #     :left -> :right
  #   end
  # end

  # def coord_options(visited, {current, direction_id}, options) do
  #   _forward_or_back =
  #     [
  #       {&up/1, :up},
  #       {&down/1, :down},
  #       {&right/1, :right},
  #       {&left/1, :left}
  #     ]
  #     |> Enum.reject(fn {direction, _identifier} ->
  #       if(direction_id == nil) do
  #         false
  #       else
  #         direction == opposite_direction(direction_id)
  #       end
  #     end)
  #     |> Enum.map(fn {direction, identifier} ->
  #       if(current != nil) do
  #         {direction.(current), identifier}
  #       else
  #         nil
  #       end
  #     end)
  #     |> Enum.filter(fn exists -> exists != nil end)
  #     |> Enum.filter(fn {coord, _direction_identifier} ->
  #       coord not in visited && coord in options
  #     end)
  # end

  # def find_next_coord(_visited, {_current, _direction}, [], _count), do: 0
  # def find_next_coord(_visited, nil, _options, _count), do: 0

  # def find_next_coord(visited, {current, direction}, options, count) do
  #   if options not in visited do
  #     visited = MapSet.put(visited, current)

  #     attempt_to_find_next_coord_options =
  #       List.last(coord_options(visited, {current, direction}, options))

  #     if(attempt_to_find_next_coord_options != nil) do
  #       {new_coord, new_direction} = attempt_to_find_next_coord_options

  #       count =
  #         if(new_direction != direction) do
  #           count + 1
  #         else
  #           count
  #         end

  #       # IO.inspect({new_coord, new_direction})
  #       find_next_coord(visited, {new_coord, new_direction}, options, count)
  #     else
  #       if length(options) > 0 do
  #         options = Enum.to_list(options) -- MapSet.to_list(visited)
  #         start_point = List.first(coord_options(visited, {List.first(options), nil}, options))

  #         count + find_next_coord(visited, start_point, options, 1)
  #       else
  #         count
  #       end
  #     end
  #   end
  # end

  # def lines(list) do
  #   Enum.reduce(list, MapSet.new(), fn coord_1, acc ->
  #     neighbours_in_map =
  #       MapSet.filter(acc, fn {direction, values} ->
  #         Enum.any?(values, fn coord_2 ->
  #           direction(direction) |> Enum.any?(&neighbour?(coord_1, coord_2, &1))
  #         end)
  #       end)

  #     acc =
  #       neighbours_in_map
  #       |> Enum.reduce(acc, fn {direction, values}, acc ->
  #         acc = MapSet.delete(acc, {direction, values})
  #         values = values ++ [coord_1]
  #         MapSet.put(acc, {direction, values})
  #       end)

  #     if MapSet.size(neighbours_in_map) == 0 do
  #       acc = MapSet.put(acc, {:x, [coord_1]})
  #       MapSet.put(acc, {:y, [coord_1]})
  #     else
  #       if MapSet.size(neighbours_in_map) == 1 do
  #         [{direction, _values}] = MapSet.to_list(neighbours_in_map)

  #         _acc =
  #           case direction do
  #             :x -> MapSet.put(acc, {:y, [coord_1]})
  #             :y -> MapSet.put(acc, {:x, [coord_1]})
  #           end
  #       else
  #         acc
  #       end
  #     end
  #   end)
  # end

  def direction(dir) do
    case dir do
      :x -> [&right/1, &left/1]
      :y -> [&down/1, &up/1]
    end
  end

  def neighbour?(coord_1, coord_2, direction) do
    direction.(coord_1) == coord_2 || direction.(coord_2) == coord_1
  end

  def area(region), do: length(region)
  def price(region), do: perimeter(region) * area(region)

  def price_v2(region) do
    perimeter = perimeter_v2(region)
    area = area(region)

    IO.inspect("area: #{area}, perimeter: #{perimeter}")
    IO.inspect(perimeter * area, label: "price")

    perimeter * area
  end

  def solution_p1(board) do
    regions = region_selection(board)

    Enum.map(regions, &price/1) |> Enum.sum()
  end

  def solution_p2(board) do
    regions = region_selection(board)

    Enum.map(regions, &price_v2(&1)) |> Enum.sum()
  end
end

# IO.inspect(Region.solution_p1(input))

# part 2

file_paths
|> Enum.map(fn {file_path, expected_result} ->
  input = Region.parse_input(file_path)

  result = Region.solution_p2(input)

  if(result != expected_result) do
    IO.inspect("#{file_path} failed, expected result: #{expected_result}, result: #{result}")
  end
end)
