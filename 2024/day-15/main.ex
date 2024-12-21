require File

file_path = "input.test"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input = input |> String.split() |> Enum.map(&String.split(&1, "", trim: true))

instructions = List.last(input)
input = input |> List.delete(instructions)

IO.inspect(input, charlists: :as_lists, limit: :infinity)
IO.inspect(instructions, charlists: :as_lists, limit: :infinity)

# part 1

defmodule Pushers do
  def up({y, x}), do: {y - 1, x}
  def up_right({y, x}), do: {y - 1, x + 1}
  def up_left({y, x}), do: {y - 1, x - 1}
  def down({y, x}), do: {y + 1, x}
  def down_left({y, x}), do: {y + 1, x - 1}
  def down_right({y, x}), do: {y + 1, x + 1}
  def left({y, x}), do: {y, x - 1}
  def right({y, x}), do: {y, x + 1}

  def move(coordinates, board, direction) do
    directions = %{
      "v" => &down/2,
      "^" => &up/2,
      ">" => &right/2,
      "<" => &left/2
    }
  end

  def solution(instructions, board) do
    position_pushers =
      Enum.reduce(Enum.with_index(board), [], fn {row, y}, acc ->
        Enum.reduce(Enum.with_index(row), acc, fn {item, x}, acc ->
          if item == "@" do
            acc ++ [{y, x}]
          end
        end)
      end)

    Enum.reduce(instructions, {board, position_pushers}, fn direction, {board, position_pushers} ->
      position_pushers |> Enum.map()
    end)

    IO.inspect(position_pushers)
  end
end

# part 2
