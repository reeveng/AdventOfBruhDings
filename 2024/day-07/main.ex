require File

# IEx.configure(inspect: [limit: :infinity, charlists: :as_lists])

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input =
  input
  |> String.split("\n")
  |> Enum.map(&String.split(&1, ": "))
  |> Enum.map(fn
    row ->
      [result | tail] =
        row
        |> Enum.map(&String.split(&1, " ", trim: true))
        |> List.flatten()
        |> Enum.map(&String.to_integer(&1))
  end)

IO.inspect(input)

# part 1

defmodule Calculator do
  def left_to_right([], _function), do: nil
  def left_to_right([value], _function), do: value
  def left_to_right([a, b], function), do: function.(a, b)

  # operators
  def add(a, b), do: a + b
  def multiply(a, b), do: a * b

  # part 2
  def concat(a, b), do: "#{a}#{b}" |> String.to_integer()

  def create_list_with_operations(list),
    do:
      Enum.intersperse(
        list,
        [
          &add/2,
          &multiply/2,

          # part 2
          &concat/2
        ]
      )

  def solver([]), do: nil
  def solver([value]), do: value

  def solver([a, actions, b | tail]) do
    Enum.map(actions, fn action ->
      left_to_right([a, b], action)
    end)
    |> Enum.map(fn value ->
      solver([value | tail])
    end)
  end

  def loop(row_list) do
    Enum.filter(row_list, fn [expected_result | tail] ->
      list_with_actions = create_list_with_operations(tail)

      all_results = solver(list_with_actions)

      all_results
      |> List.flatten()
      |> Enum.any?(fn result ->
        result == expected_result
      end)
    end)
  end
end

result = Calculator.loop(input) |> Enum.map(fn [a | tail] -> a end) |> Enum.sum()

IO.inspect(result)
