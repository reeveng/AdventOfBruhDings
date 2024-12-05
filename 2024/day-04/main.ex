require File

file_path = "input.txt"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

input =
  input
  |> String.split()
  |> Enum.map(fn stringVal ->
    String.split(stringVal, "")
    |> Enum.filter(fn letter -> letter != "" end)
  end)

# part 1

wordToSearch = "XMAS"

defmodule Search do
  def transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def countWordOccurrenceInText(text, word),
    do:
      [
        countDiagonals(text, word),
        countHorizontal(text, word),
        countVertical(text, word)
      ]
      |> Enum.sum()

  def countInList(list, word) do
    IO.inspect(list)

    # loop over every item = same as joining them?
    wordLength =
      word
      |> String.split("")
      |> Enum.filter(fn letter -> letter != "" end)
      |> length()

    listOfPartitions =
      list
      |> Enum.chunk_every(wordLength, 1, :discard)
      |> Enum.map(&Enum.join/1)

    listOfPartitions |> Enum.count(fn partition -> partition == word end)
  end

  def countHorizontal(text, word) do
    text
    |> Enum.map(&countInList(&1, word))
    |> Enum.sum()
  end

  def countVertical(text, word) do
    transpose(text) |> countHorizontal(word)
  end

  def createDiagonal(text) do
    _diagonal =
      Enum.reduce(0..(length(text) - 1), %{}, fn x, diagonal ->
        Enum.reduce(0..(length(Enum.at(text, x)) - 1), diagonal, fn y, diagonal ->
          key = x - y

          currentList = Map.get(diagonal, key, [])
          currentList = currentList ++ [Enum.at(Enum.at(text, x), y)]

          Map.put(diagonal, key, currentList)
        end)
      end)
  end

  def countDiagonals(text, word) do
    reversedText = text |> Enum.map(&Enum.reverse/1)

    diagonals =
      [createDiagonal(text), createDiagonal(reversedText)]
      |> Enum.map(&Map.values/1)
      |> Enum.reduce([], fn bla, acc -> acc ++ bla end)
      |> Enum.map(&countInList(&1, word))
      |> Enum.sum()
  end
end

backwardsText = input |> Enum.reverse() |> Enum.map(&Enum.reverse/1)

occurrences =
  [
    Search.countWordOccurrenceInText(input, wordToSearch),
    Search.countWordOccurrenceInText(backwardsText, wordToSearch)
  ]
  |> Enum.sum()

IO.inspect("found matches: #{occurrences}")

# part 2

mAndS = ["M", "S"]

inputWithIndex = input |> Enum.with_index()

xMassesFoundPerRow =
  Enum.map(inputWithIndex, fn {row, y} ->
    row
    |> Enum.with_index()
    |> Enum.count(fn {element, x} ->
      noEdgeElement =
        x - 1 >= 0 and y - 1 >= 0

      if element == "A" && noEdgeElement do
        previousRow = Enum.at(input, y - 1, [])
        nextRow = Enum.at(input, y + 1, [])

        diagonal1 =
          [Enum.at(previousRow, x - 1), Enum.at(nextRow, x + 1)]

        diagonal2 =
          [Enum.at(previousRow, x + 1), Enum.at(nextRow, x - 1)]

        [diagonal1, diagonal2]
        |> Enum.all?(fn [a, b] ->
          a in mAndS and b in mAndS and a != b
        end)
      end
    end)
  end)

IO.inspect(xMassesFoundPerRow)

amountOfXMassesFound = xMassesFoundPerRow |> Enum.sum()

IO.inspect("amount of xmasses found: #{amountOfXMassesFound}")
