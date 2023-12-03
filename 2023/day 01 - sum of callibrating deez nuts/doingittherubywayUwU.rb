require 'set'

# .lines(chomp: true) = split on line endings (kind of)
dings = File.read("input.txt").lines(chomp: true).filter_map{|x|
  x
}

# # -------------------------------
# # part 1
# # -------------------------------

# puts dings.sum{|q|
#   v=q.scan(/\d/)
#   (v.first + v.last).to_i
# }

# # -------------------------------
# # part 2
# # -------------------------------

def funct(text, type)
  if (text) then
    mapStringNumberToNumber = {
      "zero": "0",
      "one": "1",
      "two": "2",
      "three": "3",
      "four": "4",
      "five": "5",
      "seven": "7",
      "six": "6",
      "eight": "8",
      "nine": "9",
    }

    output = mapStringNumberToNumber.to_a.filter_map{ |key, value|
      foundValueAtIndex = type == :min ? text.index(key.to_s) : text.rindex(key.to_s)
      foundValueAtIndex ? [foundValueAtIndex, value] : nil
    }

    output
  else
    nil
  end
end

puts dings.sum{ |q|
  start, ending = funct(q.scan(/^[a-z]+/i).first, :min), funct(q.scan(/[a-z]+$/i).last, :max)
  numbers=[
    start && start.size > 0 && start.min_by{|a,b| a}.last,
    *q.scan(/\d/),
    ending && ending.size > 0 && ending.max_by{|a,b| a}.last
  ].filter_map{|a| a && a.to_s}

  (numbers.first + numbers.last).to_i
}

