require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

{list1, list2} =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(fn stringValue ->
    stringValue
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end)
  |> Enum.unzip()

list1 =
  list1
  |> Enum.sort()

list2 =
  list2
  |> Enum.sort()

# part 1

bla =
  [list1, list2]
  |> Enum.zip()
  |> Enum.reduce(0, fn {el1, el2}, acc -> acc + abs(el1 - el2) end)

IO.inspect(bla)

# part 2

otherBla =
  list1
  |> Enum.reduce(0, fn el1, acc ->
    acc +
      el1 *
        Enum.count(list2, fn ding ->
          ding == el1
        end)
  end)

IO.inspect(otherBla)
