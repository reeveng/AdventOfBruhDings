require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input = input |> String.split() |> Enum.map(&String.to_integer/1)

IO.inspect(input, charlists: :as_lists, limit: :infinity)

# part 1

defmodule Stone do
  def solution(list, blink_count) do
    blink(list, blink_count)
  end

  def blink(list, blink_count) do
    IO.inspect(blink_count, label: "blink count")

    cond do
      blink_count > 0 ->
        blink(split_stones(list), blink_count - 1)

      blink_count == 0 ->
        length(list)
    end
  end

  def split_stones(list) do
    Enum.map(list, fn stone ->
      cond do
        stone == 0 ->
          1

        rem(String.length(Integer.to_string(stone)), 2) == 0 ->
          string_representation_of_stone =
            Integer.to_string(stone)

          string_representation_of_stone
          |> String.split("", trim: true)
          |> Enum.chunk_every(floor(String.length(string_representation_of_stone) / 2))
          |> Enum.map(&Enum.join/1)

        true ->
          stone * 2024
      end
    end)
    |> List.flatten()
    |> Enum.map(fn stone ->
      if is_integer(stone) do
        stone
      else
        String.to_integer(stone)
      end
    end)
  end
end

# IO.inspect(Stone.solution(input, 25))

# part 2

defmodule StoneV2 do
  def solution(list, blink_count), do: solution(list, blink_count, Map.new())

  def solution(list, blink_count, cache) do
    Enum.reduce(list, {0, cache}, fn stone, {total, cache} ->
      {result, cache} = blink(stone, blink_count, cache)

      {result + total, cache}
    end)
  end

  def blink(stone, blink_count, cache) do
    cond do
      blink_count == 0 ->
        {1, cache}

      blink_count > 0 ->
        key = {stone, blink_count}

        if(Map.has_key?(cache, key)) do
          {Map.get(cache, key), cache}
        else
          ding = split_stone(stone)

          {result, cache} = solution(ding, blink_count - 1, cache)

          cache = Map.put(cache, key, result)

          {result, cache}
        end
    end
  end

  def split_stone(stone) do
    cond do
      stone == 0 ->
        [1]

      rem(String.length(Integer.to_string(stone)), 2) == 0 ->
        string_representation_of_stone =
          Integer.to_string(stone)

        string_representation_of_stone
        |> String.split("", trim: true)
        |> Enum.chunk_every(floor(String.length(string_representation_of_stone) / 2))
        |> Enum.map(&Enum.join/1)
        |> List.flatten()
        |> Enum.map(&String.to_integer/1)

      true ->
        [stone * 2024]
    end
  end
end

{res, _cache} = StoneV2.solution(input, 25)

IO.inspect(res)
