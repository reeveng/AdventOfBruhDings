require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

[rules, ordered_numbers] = input |> String.split("\n\n") |> Enum.map(&String.split/1)

# prep

rules =
  rules
  |> Enum.map(&String.split(&1, "|"))
  |> Enum.map(fn thing ->
    Enum.map(thing, &String.to_integer/1)
  end)
  # TODO: can be shortened with Map.merge
  |> Enum.reduce(%{}, fn [num_before, num_after], acc ->
    update_in(acc, [num_before], &((&1 || []) ++ [num_after]))
  end)

ordered_numbers =
  ordered_numbers
  |> Enum.map(&String.split(&1, ","))
  |> Enum.map(fn thing ->
    Enum.map(thing, &String.to_integer/1)
  end)

# part 1

defmodule Check do
  def ordered([], _ordering_rules), do: true
  def ordered([_], _ordering_rules), do: true

  def ordered(list, ordering_rules) do
    list_with_index = Enum.with_index(list)

    Enum.all?(list_with_index, fn {number, index} ->
      must_come_after_current_number = Map.get(ordering_rules, number, [])
      sliced_list_till_index = Enum.slice(list, 0..index)

      result =
        Enum.all?(
          sliced_list_till_index,
          &(&1 not in must_come_after_current_number)
        )
    end)
  end

  def middle_element([]), do: nil
  def middle_element([a]), do: a

  def middle_element(list) do
    list_length = length(list)
    middle_index = floor(list_length / 2)

    middle_element = Enum.at(list, middle_index, nil)
  end
end

IO.inspect(rules, charlists: :as_lists, limit: :infinity)

order_number_lists =
  Enum.filter(ordered_numbers, &Check.ordered(&1, rules))
  |> Enum.map(&Check.middle_element(&1))
  |> Enum.sum()

IO.inspect(order_number_lists, charlists: :as_lists, limit: :infinity)

# part 2

not_order_number_lists =
  Enum.filter(ordered_numbers, &(!Check.ordered(&1, rules)))
  |> Enum.map(
    &Enum.sort(&1, fn a, b ->
      Check.ordered([a, b], rules)
    end)
  )
  |> Enum.map(&Check.middle_element(&1))
  |> Enum.sum()

IO.inspect(not_order_number_lists, charlists: :as_lists, limit: :infinity)
