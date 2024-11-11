require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

dimensions =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(fn stringValue ->
    stringValue
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end)

# part 1

total_paper_needed =
  dimensions
  |> Enum.map(fn {l, w, h} ->
    surface_area = 2 * l * w + 2 * w * h + 2 * h * l
    slack = Enum.min([l * w, w * h, h * l])
    surface_area + slack
  end)
  |> Enum.sum()

IO.puts("Total wrapping paper needed: #{total_paper_needed}")

# part 2

total_ribbon_needed =
  dimensions
  |> Enum.map(fn {l, w, h} ->
    [smallest, second_smallest | _] = Enum.sort([l, w, h])
    wrap_ribbon = 2 * (smallest + second_smallest)
    bow_ribbon = l * w * h
    wrap_ribbon + bow_ribbon
  end)
  |> Enum.sum()

IO.puts("Total ribbon needed: #{total_ribbon_needed}")
