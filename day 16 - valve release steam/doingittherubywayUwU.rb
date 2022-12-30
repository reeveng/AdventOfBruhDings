require "set"

# .lines(chomp: true) = split on line endings (kind of)
$graph = File.read("input.txt").lines(chomp: true).filter_map{|x|
  x=x.split(" has flow rate=")
    .flat_map{_1.split("Valve ")}
    .flat_map{_1.split(?;)}
    .flat_map{_1.split}
    .flat_map{_1.split(?,)}
  a,b,_,_,_,_,*x=x
  b=b.to_i

  ding = { }
  ding["id"] = a
  ding["rate"] = b
  ding["neighbours"] = x
  ding
}
puts $graph=$graph.sort_by{-_1["rate"]}

$numberOfItemsDifferentFrom0 = $graph.filter{_1["rate"]>0}.size

# # -------------------------------
# # part 1
# # -------------------------------
# ---------------------------------
# # search algo bfs style
# # -------------------------------
# $items=[["AA",30,0,[]]]
# $maxScore=0

# def bfs(currentPos, ttl, score, opened)
#   currentItem = $graph.find{_1["id"]==currentPos}

#   if (ttl == 0 || opened.size == $numberOfItemsDifferentFrom0) then
#     return score
#   end
#   ttl -= 1

#   if (currentItem["rate"] > 0 && !opened.include?(currentPos) && ttl > 0) then
#     currentItem["neighbours"].each{
#       $items << [_1, ttl-1, score+(currentItem["rate"]*ttl), [*opened, currentPos]]
#     }
#   end

#   currentItem["neighbours"].each{
#     $items << [_1, ttl, score, opened]
#   }
#   return 0
# end

# counter = 0
# while ($items.size > 0) do
#   if ($items.size > 10000000) then
#     $items = $items.sort_by{-_1[2]/(30-_1[1])}[0..1000000]
#   end

#   currentPos, ttl, score, opened = $items.shift
#   $maxScore = [bfs(currentPos, ttl, score, opened), $maxScore].max

#   if (counter % 100000 == 0) then
#     puts [counter, score, ttl, $maxScore]*", "
#   end
# end

# puts $maxScore

# # -------------------------------
# # part 2
# # -------------------------------
# ---------------------------------
# # search algo bfs style
# # -------------------------------
$items=[[["AA", 26, "AA", 26],0,[]]]
$maxScore=0

def bfs(currentPositions, score, opened)
  cPosMe, ttlMe, cPosEle, ttlEle = currentPositions

  cMe = $graph.find{_1["id"]==cPosMe}
  cEle = $graph.find{_1["id"]==cPosEle}

  if (ttlMe == 0 && ttlEle == 0 || opened.size == $numberOfItemsDifferentFrom0) then
    return score
  end

  if (cMe["rate"] > 0 && !opened.include?(cPosMe) && ttlMe >= 2) then
    cMe["neighbours"].each{
      $items << [[_1, ttlMe-2, cPosEle, ttlEle], score+(cMe["rate"]*ttlMe), [*opened, cPosMe]]
    }
  end
  if (cEle["rate"] > 0 && !opened.include?(cPosEle) && ttlEle >= 2) then
    cEle["neighbours"].each{
      $items << [[_1, ttlEle-2, cPosMe, ttlMe], score+(cEle["rate"]*ttlEle), [*opened, cPosEle]]
    }
  end

  if (ttlMe >= 1) then
    cMe["neighbours"].each{
      $items << [[_1, ttlMe-1, cPosEle, ttlEle], score, opened]
    }
  end
  if (ttlEle >= 1) then
    cEle["neighbours"].each{
      $items << [[_1, ttlEle-1, cPosMe, ttlMe], score, opened]
    }
  end

  return 0
end

counter = 0
while (!$items.empty?) do
  if ($items.size > 1000000) then
    $items = $items.sort_by{-_1[1] / (26 * 2 - _1[0][1] - _1[0][3]) }[0..500000]
  end

  currentPositions, score, opened = $items.shift
  $maxScore = [bfs(currentPositions, score, opened), $maxScore].max

  counter += 1
  if (counter % 100000 == 0) then
    puts [counter, score, "ttl p1 #{currentPositions[1]} <=> ttl p2 #{currentPositions[3]}", $maxScore]*", "
  end
end

puts $maxScore
