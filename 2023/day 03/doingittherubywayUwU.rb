require 'set'

# .lines(chomp: true) = split on line endings (kind of)
dings = File.read("input.txt").lines(chomp: true).filter_map{|x|
  x
}

# # -------------------------------
# # part 1
# # -------------------------------

foundNumbers = []

(0...dings.length).each{|i|
  (0...dings[i].length).each{|j|
    if /\d/.match(dings[i][j]) then
      foundNumbers << [i, j]
    end
  }
}

directions = [
  [0,1],
  [1,1],
  [1,0],
  [-1,0],
  [-1,-1],
  [1,-1],
  [0,-1],
  [-1,1],
]

# go over them, check if something is around, if so append true to the array
foundNumbers.map{|item|
  yitem, xitem = item

  item << directions.any?{|y,x|
    row = dings[yitem + y]
    row && /[^\.\d]/.match(row[xitem + x])
  }
}

solutionP1Array = []
foundNumbers.each{|yitem, xitem, hasSymbolAdjacent|
  yaccumulated, xaccumulated, hasSymbolAccumulated = exists = solutionP1Array[-1]
  if (
    exists &&
    yitem == yaccumulated &&
    xitem -1 == xaccumulated[1]
  ) then
    solutionP1Array[-1] = [
      yitem,
      [xaccumulated[0], xitem],
      solutionP1Array[-1][2] || hasSymbolAdjacent
    ]
  else
    solutionP1Array << [yitem, [xitem, xitem], hasSymbolAdjacent]
  end
}

p solutionP1Array.sum{|yitem, (startX, endX), hasSymbolAdjacent|
  hasSymbolAdjacent ? dings[yitem][startX..endX].to_i : 0
}

# # -------------------------------
# # part 2
# # -------------------------------

foundNumbers = []

(0...dings.length).each{|i|
  (0...dings[i].length).each{|j|
    if /\d/.match(dings[i][j]) then
      foundNumbers << [i, j]
    end
  }
}

directions = [
  [0,1],
  [1,1],
  [1,0],
  [-1,0],
  [-1,-1],
  [1,-1],
  [0,-1],
  [-1,1],
]

mapdingsOfSymbol = {}

foundNumbers.map{|item|
  yitem, xitem = item

  foundItemNextToItIGuess = directions.each{|y,x|
    row = dings[yitem + y]

    if row && /\*/.match(row[xitem + x]) then
      key = "#{yitem + y} #{xitem + x}"
      if !mapdingsOfSymbol[key] then
        mapdingsOfSymbol[key] = []
      end

      mapdingsOfSymbol[key] << item
    end
  }

  item << directions.any?{|y,x|
    row = dings[yitem + y]
    row && /[^\.\d]/.match(row[xitem + x])
  }
}

solutionP1Array = []
foundNumbers.each{|yitem, xitem, hasSymbolAdjacent|
  yaccumulated, xaccumulated, hasSymbolAccumulated = exists = solutionP1Array[-1]
  if (
    exists &&
    yitem == yaccumulated &&
    xitem -1 == xaccumulated[1]
  ) then
    solutionP1Array[-1] = [
      yitem,
      [xaccumulated[0], xitem],
      solutionP1Array[-1][2] || hasSymbolAdjacent
    ]
  else
    solutionP1Array << [yitem, [xitem, xitem], hasSymbolAdjacent]
  end
}

solutionP1Array = solutionP1Array.map{|yitem, (startX, endX), _|
  [dings[yitem][startX..endX].to_i, yitem, [startX, endX]]
}

solutionP1Array

p mapdingsOfSymbol.map{|key, value|
  nearlytherebutnotcompletelyyetman = value.map{|dingY, dingX, _|
    solutionP1Array.find{|actualnumberWegottauseman ,yitem, (startX, endX)|
      dingY == yitem && dingX >= startX && dingX <= endX
    }
  }.uniq.map{|actualnumberWegottauseman ,yitem, (startX, endX)|
    actualnumberWegottauseman
  }

  nearlytherebutnotcompletelyyetman.size == 2 ? eval(nearlytherebutnotcompletelyyetman*?*) : 0
}.sum
