require File

ExUnit.start()

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

dings =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(fn stringValue ->
    stringValue
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end)

IO.inspect(dings)

# part 1
# The levels are either all increasing or all decreasing.
# Any two adjacent levels differ by at least one and at most three
defmodule Safe do
  @doc """
  ## Examples

  This one passes
  ```elixir
  iex> Safe.increase([1, 2])
  true
  ```

  This one does not pass
  ```elixir
  iex> Safe.increase([2, 1])
  false
  ```
  """

  def increase([]), do: true
  def increase([_]), do: true
  def increase([a, b]), do: b - a <= 3 and b - a > 0
  def increase([a, b | tail]), do: increase([a, b]) && increase([b | tail])

  def decrease([]), do: true
  def decrease([_]), do: true
  def decrease([a, b]), do: a - b <= 3 and a - b > 0
  def decrease([a, b | tail]), do: decrease([a, b]) && decrease([b | tail])

  def isSafe([]), do: true
  def isSafe([_]), do: true
  def isSafe(list), do: increase(list) || decrease(list)

  def isSafeTolerant([]), do: true
  def isSafeTolerant([_]), do: true

  def isSafeTolerant(list) do
    if(increase(list) || decrease(list)) do
      true
    else
      Enum.any?(0..(length(list) - 1), fn idx ->
        new_list = List.delete_at(list, idx)
        increase(new_list) || decrease(new_list)
      end)
    end
  end
end

reduction =
  dings
  |> Enum.count(fn list -> Safe.isSafe(list) end)

IO.inspect(reduction)

# part 2

differentReduction =
  dings
  |> Enum.count(&Safe.isSafeTolerant(&1))

IO.inspect(differentReduction, charlists: :as_lists, limit: :infinity)
