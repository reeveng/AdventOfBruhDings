require 'set'

# .lines(chomp: true) = split on line endings (kind of)
windDirections = File.read("input.txt").lines(chomp: true).filter_map{|x|
  x
}[0].chars

print windDirections

width = 7
types = [
  # horizontal line
  [
    # individual points
    [0,0],[1,0],[2,0],[3,0]
  ],

  # plus
  [
    # individual points
    [1,1],[1,2],[1,3],[0,2],[3,2]
  ],

  # L shaped weird ding
  [
    # individual points
    [0,0],[1,0],[2,0],[2,1],[2,2]
  ],

  # vertical line
  [
    # individual points
    [0,0],[0,1],[0,2],[0,3]
  ],

  # square
  [
    # individual points
    [0,0],[1,1],[0,1],[1,0]
  ],
]

# # -------------------------------
# # part 1
# # -------------------------------
# Each rock appears so that its left edge is two units away from the left wall
# and its bottom edge is three units above the highest rock in the room
locationsOfRocks=Set.new
highest=0
pawnDingAboveHighest=3

currentType=0
currentDirection=0

2022.times{
  # shift down till any of the sides touch
  # calc highest point of rock type and cross-match with highest which is highest

  currentShapePos = types[currentType]
  currentShapePos = currentShapePos.map{[_1[0], _1[1] + highest + pawnDingAboveHighest]}

  puts currentShapePos*""

  # loop over the rock types
  # TODO: create above anything function
  while (!aboveAnything) do
    # loop over the wind directions
    currentDirection = windDirections[currentDirection] == "<" ? -1 : 1

    # shift to side X-1 or X+1
    # TODO: check wether or not shape already on one of the sides
    # TODO: check wether or not shape next to other shape and thus can't be pushed further in direction
    currentShapePos = currentShapePos.map{[[[_1[0]+currentDirection, 0].max, 7].min, _1[1]]}

    currentDirection += 1
    currentDirection %= windDirections.size
  end

  currentType += 1
  currentType %= types.size
}

# print highest point of all shapes
puts highest


# # -------------------------------
# # part 2
# # -------------------------------

