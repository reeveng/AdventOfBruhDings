require File

file_path = "input.test"

if(!File.exists?(file_path)) do
  IO.puts("bruh, this file doesn't exist")
end

{:ok, input} = File.read(file_path)

# part 1

IO.inspect(input, charlists: :as_lists, limit: :infinity)

# part 2
