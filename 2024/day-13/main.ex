require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input =
  String.split(input, "\n", trim: true)
  |> Enum.chunk_every(3)
  |> Enum.map(fn item ->
    item
    |> Enum.map(fn otherItem ->
      [a, b] = otherItem |> String.split(": ")

      [_a, b, _c, d] =
        b
        |> String.split(", ")
        |> Enum.map(fn coord ->
          coord
          |> String.split(["+", "="])
        end)
        |> List.flatten()

      [b, d] = [b, d] |> Enum.map(&String.to_integer/1)

      _a = a |> String.replace("Button ", "")

      {d, b}
    end)
  end)

IO.inspect(input, charlists: :as_lists, limit: :infinity)

# part 1

defmodule Solver do
  def find_prize([{ay, ax}, {by, bx}, {prize_y, prize_x}]) do
    Enum.reduce(Range.new(0, 100), [], fn a_times, acc ->
      Enum.reduce(Range.new(0, 100), acc, fn b_times, acc ->
        y_match = a_times * ay + b_times * by == prize_y
        x_match = a_times * ax + b_times * bx == prize_x

        if y_match && x_match do
          acc ++ [a_times * 3 + b_times * 1]
        else
          acc
        end
      end)
    end)
    |> IO.inspect()
  end

  def solution(list) do
    list
    |> Enum.map(&find_prize/1)
    |> Enum.reject(fn list -> length(list) == 0 end)
    |> Enum.map(&Enum.min/1)
    |> IO.inspect()
    |> Enum.sum()
  end
end

Solver.solution(input) |> IO.inspect()

# part 2

defmodule SolverV2 do
  def is_prize?([{ay, ax}, {by, bx}, {prize_y, prize_x}], a_times, b_times) do
    y_match = a_times * ay + b_times * by == prize_y
    x_match = a_times * ax + b_times * bx == prize_x

    IO.inspect("Y: #{a_times * ay + b_times * by}, goal Y: #{prize_y}")
    IO.inspect("X: #{a_times * ax + b_times * bx}, goal X: #{prize_x}")

    y_match && x_match
  end

  def convert_to_sol(a_times, b_times) do
    a_times * 3 + b_times * 1
  end

  def find_prize([{y1, x1}, {y2, x2}, {py, px}]) do
    px = px + 10_000_000_000_000
    py = py + 10_000_000_000_000

    b = round((px - py / y1 * x1) / (-y2 / y1 * x1 + x2))
    a = round((py - b * y2) / y1)

    res = convert_to_sol(a, b)

    if is_prize?([{y1, x1}, {y2, x2}, {py, px}], a, b) do
      res
    else
      nil
    end
  end

  def solution(list) do
    list
    |> Enum.map(&find_prize/1)
    |> IO.inspect()
    |> Enum.reject(fn res -> res == nil end)
    |> Enum.sum()
  end
end

SolverV2.solution(input) |> IO.inspect()
# too low
# 82452701449184

# not right
# 875318608908
