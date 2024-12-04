require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

# part 1

test = Regex.scan(~r/mul\(\d+,\d+\)/, input)

test =
  test
  |> List.flatten()
  |> Enum.map(fn multiplication ->
    v =
      Regex.scan(~r/\d+/, multiplication)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.product()
  end)
  |> Enum.sum()

IO.inspect(test)

# part 2

test2 = Regex.scan(~r/(mul\(\d+,\d+\)|don't\(\)|do\(\))/, input)

{bruh, test2} =
  test2
  |> Enum.reduce({false, []}, fn
    [first, _second], {foundDoNotPerformActions, acc} ->
      case(first) do
        "don't()" ->
          {true, acc}

        "do()" ->
          {false, acc}

        something ->
          if(foundDoNotPerformActions) do
            {foundDoNotPerformActions, acc}
          else
            {foundDoNotPerformActions, [acc, something]}
          end
      end
  end)

ding =
  test2
  |> List.flatten()
  |> Enum.map(fn multiplication ->
    v =
      Regex.scan(~r/\d+/, multiplication)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.product()
  end)
  |> Enum.sum()

IO.inspect(ding)
