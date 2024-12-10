require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input = input |> String.split("", trim: true) |> Enum.map(&String.to_integer/1)

IO.inspect(input, charlists: :as_lists, limit: :infinity)

# part 1

# defmodule CheckSum do
#   require Integer

#   def disk_map(list) do
#     result_map =
#       Enum.with_index(list)
#       |> Enum.reduce(%{}, fn {num, index}, acc ->
#         if Integer.is_even(index) do
#           Map.update(acc, :even, [num], &(&1 ++ [num]))
#         else
#           Map.update(acc, :odd, [num], &(&1 ++ [num]))
#         end
#       end)

#     [{_, evens}, {_, odds}] = Map.to_list(result_map)

#     evens =
#       Enum.map(Enum.with_index(evens), fn {amount, index} ->
#         if(amount > 0) do
#           Enum.map(1..amount, fn _ -> index end)
#         else
#           []
#         end
#       end)

#     odds =
#       Enum.map(odds, fn amount ->
#         if(amount > 0) do
#           Enum.map(1..amount, fn _ ->
#             "."
#           end)
#         else
#           []
#         end
#       end)

#     Enum.reduce(0..(length(list) - 1), [], fn index, acc ->
#       if Integer.is_even(index) do
#         acc ++ Enum.at(evens, floor(index / 2))
#       else
#         acc ++ Enum.at(odds, floor(index / 2))
#       end
#     end)
#   end

#   def swap(list), do: swap(list, 0)

#   def swap(list, count) do
#     if rem(count, 5000) == 0 do
#       IO.puts("Count: #{count}")
#     end

#     joined_list = Enum.join(list)

#     if !String.match?(joined_list, ~r/^\d+[.]{0,}?$/) do
#       first_index_of_dot = Enum.find_index(list, &(&1 == "."))

#       reversed_list = Enum.reverse(list)

#       first_non_dot_from_the_back_index =
#         length(list) - Enum.find_index(reversed_list, &(&1 != ".")) - 1

#       first_non_dot_from_the_back = Enum.at(list, first_non_dot_from_the_back_index)

#       list = update_list(list, first_index_of_dot, first_non_dot_from_the_back)
#       list = update_list(list, first_non_dot_from_the_back_index, ".")

#       swap(list, count + 1)
#     else
#       list
#     end
#   end

#   def solution_p1(list) do
#     IO.puts("started mapping")
#     list = disk_map(list)
#     IO.puts("finished mapping")

#     IO.inspect(list)

#     IO.puts("started swapping")
#     list = swap(list)
#     IO.puts("finished swapping")

#     Enum.map(Enum.with_index(list), fn {value, index} ->
#       if(value != ".") do
#         value * index
#       else
#         0
#       end
#     end)
#   end

#   def update_list(list, x, value) do
#     if(x >= 0 && x < length(list)) do
#       List.update_at(list, x, fn _ -> value end)
#     else
#       list
#     end
#   end
# end

# something = CheckSum.solution_p1(input)
# IO.inspect(something, charlists: :as_lists, limit: :infinity)

# something_else = something |> Enum.sum()
# IO.inspect(something_else, charlists: :as_lists, limit: :infinity)

# part 2

defmodule CheckSumV2 do
  require Integer

  def disk_map(list) do
    result_map =
      Enum.with_index(list)
      |> Enum.reduce(%{}, fn {num, index}, acc ->
        if Integer.is_even(index) do
          Map.update(acc, :even, [num], &(&1 ++ [num]))
        else
          Map.update(acc, :odd, [num], &(&1 ++ [num]))
        end
      end)

    [{_, evens}, {_, odds}] = Map.to_list(result_map)

    evens =
      Enum.map(Enum.with_index(evens), fn {amount, index} ->
        if(amount > 0) do
          Enum.map(1..amount, fn _ -> index end)
        else
          []
        end
      end)

    odds =
      Enum.map(odds, fn amount ->
        create_dot_list(amount)
      end)

    {Enum.reduce(0..(length(list) - 1), [], fn index, acc ->
       if Integer.is_even(index) do
         acc ++ [Enum.at(evens, floor(index / 2))]
       else
         acc ++ [Enum.at(odds, floor(index / 2))]
       end
     end), evens}
  end

  def swap(list, evens) do
    evens = evens |> Enum.reverse()

    Enum.reduce(evens, list, fn even_values, acc ->
      # print(acc)

      even_index =
        Enum.find_index(acc, fn value_list ->
          List.first(value_list) == List.first(even_values)
        end)

      index =
        Enum.find_index(Enum.with_index(acc), fn {value_list, value_index} ->
          first_value = List.first(value_list)

          first_value == "." &&
            length(value_list) >=
              length(even_values) && value_index < even_index
        end)

      if index do
        bruh_values = Enum.at(acc, index)
        length_diff = abs(length(bruh_values) - length(even_values))
        dot_list = create_dot_list(length_diff)

        acc = List.replace_at(acc, index, dot_list)
        acc = List.insert_at(acc, index, even_values)

        new_dot_list = create_dot_list(length(even_values))
        acc = List.replace_at(acc, even_index + 1, new_dot_list)

        acc
      else
        acc
      end
    end)
  end

  def create_dot_list(amount) do
    if(amount > 0) do
      Enum.map(1..amount, fn _ ->
        "."
      end)
    else
      []
    end
  end

  def print(list_of_tuples) do
    IO.inspect(
      Enum.map(list_of_tuples, fn values ->
        values
      end)
      |> List.flatten()
      |> Enum.join(),
      charlists: :as_lists,
      limit: :infinity
    )
  end

  def solution(list) do
    IO.puts("started mapping")
    {list, evens} = disk_map(list)
    IO.puts("finished mapping")

    IO.inspect(list)

    IO.puts("started swapping")
    list = swap(list, evens)
    IO.puts("finished swapping")

    # IO.inspect(list, charlists: :as_lists, limit: :infinity)

    list =
      list
      |> List.flatten()

    Enum.map(Enum.with_index(list), fn {value, index} ->
      if(value != ".") do
        value * index
      else
        0
      end
    end)
  end

  def update_list(list, x, value) do
    if(x >= 0 && x < length(list)) do
      List.update_at(list, x, fn _ -> value end)
    else
      list
    end
  end
end

something = CheckSumV2.solution(input)

something_else = something |> Enum.sum()
IO.inspect(something_else, charlists: :as_lists, limit: :infinity)
