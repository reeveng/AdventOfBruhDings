require 'set'

# .lines(chomp: true) = split on line endings (kind of)
dings = File.read("input.txt").lines(chomp: true).map{|x|
  x.chomp.chars.map{_1.ord-'a'.ord+1}
}
# print dings

# # -------------------------------
# # part 1
# # -------------------------------
# # find starting location
# strS = 'S'.ord-'a'.ord+1
# startY=(0...dings.size).find{|i|
#   dings[i].find{_1==strS}
# }
# startX=dings[startY].index(strS)
# print [startY,startX]

# # find end location
# strE = 'E'.ord-'a'.ord+1
# endY=(0...dings.size).find{|i|
#   dings[i].find{_1==strE}
# }
# endX=dings[endY].index(strE)
# print [endY,endX]

# # max'es
# maxY = dings.size
# maxX = dings[0].size

# # current minnest min
# $minnestMin = maxY*maxX;

# # search algo botched
# # def searching(visited, value, endValue, maxValue, dings)
# #   valueX, valueY = value
# #   endX, endY = endValue
# #   maxX, maxY = maxValue

# #   if($minnestMin < visited.size) then
# #     return
# #   end

# #   if(valueX == endX && valueY == endY) then
# #     $minnestMin=[$minnestMin, visited.size].min
# #     print $minnestMin
# #     return
# #   end

# #   if (!visited.include?(value*",")) then
# #     newVisited = [*visited, value*","]
# #     results=[]

# #     currentValue = dings[valueY][valueX]
# #     if(
# #         valueY + 1 < maxY && valueX < maxX &&
# #         dings[valueY + 1][valueX] <= currentValue + 1
# #       ) then
# #       searching(newVisited, [valueX, valueY + 1], endValue, maxValue, dings)
# #     end
# #     if(
# #         valueY - 1 >= 0 && valueX < maxX &&
# #         dings[valueY - 1][valueX] <= currentValue + 1
# #       ) then
# #       searching(newVisited, [valueX, valueY - 1], endValue, maxValue, dings)
# #     end
# #     if(
# #         valueY < maxY && valueX - 1 >= 0 &&
# #         dings[valueY][valueX - 1] <= currentValue + 1
# #       ) then
# #       searching(newVisited, [valueX - 1, valueY], endValue, maxValue, dings)
# #     end
# #     if(
# #         valueY < maxY && valueX + 1 < maxX &&
# #         dings[valueY][valueX + 1] <= currentValue + 1
# #       ) then
# #       searching(newVisited, [valueX + 1, valueY], endValue, maxValue, dings)
# #     end

# #     return
# #   end

# #   return
# # end
# # searching([], [startX, startY], [endX, endY], [maxX, maxY], dings)



# # remove -13 and -27
# dings = dings.map{|x|x.map{
#   if(_1==strS)then
#     1
#   elsif(_1==strE)then
#     26
#   else
#     _1
#   end
# }}

# # -------------------------------
# # search algo bfs style
# # -------------------------------
# counter=0
# visited = Set.new
# queue = [[startX, startY, 0]]
# while !queue.empty? do
#   value = queue.shift
#   valueX, valueY, counter = value
#   if [valueX,valueY]*","==[endX,endY]*"," then
#     puts value
#     puts "counter %d"%counter
#     exit
#   end

#   if(!visited.include?([valueX,valueY]*","))then
#   visited.push([valueX,valueY]*",")

#   currentValue = dings[valueY][valueX]
#   adjacent=[]
#   counter += 1
#     if(
#       valueY + 1 < maxY && valueX < maxX &&
#       dings[valueY + 1][valueX] <= currentValue + 1 &&
#       !visited.include?([valueX, valueY+1]*",")
#     ) then
#       adjacent.push([valueX, valueY+1,counter])
#     end
#     if(
#       valueY - 1 >= 0 && valueX < maxX &&
#       dings[valueY - 1][valueX] <= currentValue + 1 &&
#       !visited.include?([valueX, valueY-1]*",")
#     ) then
#       adjacent.push([valueX, valueY-1,counter])
#     end
#     if(
#       valueY < maxY && valueX - 1 >= 0 &&
#       dings[valueY][valueX - 1] <= currentValue + 1 &&
#       !visited.include?([valueX-1, valueY]*",")
#     ) then
#       adjacent.push([valueX-1, valueY,counter])
#     end
#     if(
#       valueY < maxY && valueX + 1 < maxX &&
#       dings[valueY][valueX + 1] <= currentValue + 1 &&
#       !visited.include?([valueX+1, valueY]*",")
#     ) then
#       adjacent.push([valueX+1, valueY,counter])
#     end

#     queue.push(*adjacent)
#   end
# end

# puts value


# -------------------------------
# part 2
# -------------------------------
# find end location
strE = 'E'.ord-'a'.ord+1
endY=(0...dings.size).find{|i|
  dings[i].find{_1==strE}
}
endX=dings[endY].index(strE)
# print [endY,endX]

# max'es
maxY = dings.size
maxX = dings[0].size

# remove -13 and -27
strS = 'S'.ord-'a'.ord+1
dings = dings.map{|x|x.map{
  if(_1==strS)then
    1
  elsif(_1==strE)then
    26
  else
    _1
  end
}}


# ---------------------------------
# # search algo bfs style
# # -------------------------------
minnestMin=1e4

dings.each_with_index{
  |row, y|
  row.each_with_index{
  |value, x|
if(value==1)then
counter=0
visited = Set.new
queue = [[x, y, 0]]
while !queue.empty? do
  value = queue.shift
  valueX, valueY, counter = value
  if [valueX,valueY]*","==[endX,endY]*"," then
    minnestMin=[counter,minnestMin].min
    break;
  end

  if(minnestMin<counter)then
    break
  end

  if(!visited.include?([valueX,valueY]*","))then
  visited << ([valueX,valueY]*",")

  currentValue = dings[valueY][valueX]
  adjacent=[]
  counter += 1
    if(
      valueY + 1 < maxY && valueX < maxX &&
      dings[valueY + 1][valueX] <= currentValue + 1 &&
      !visited.include?([valueX, valueY+1]*",")
    ) then
      adjacent << ([valueX, valueY+1,counter])
    end
    if(
      valueY - 1 >= 0 && valueX < maxX &&
      dings[valueY - 1][valueX] <= currentValue + 1 &&
      !visited.include?([valueX, valueY-1]*",")
    ) then
      adjacent << ([valueX, valueY-1,counter])
    end
    if(
      valueY < maxY && valueX - 1 >= 0 &&
      dings[valueY][valueX - 1] <= currentValue + 1 &&
      !visited.include?([valueX-1, valueY]*",")
    ) then
      adjacent << ([valueX-1, valueY,counter])
    end
    if(
      valueY < maxY && valueX + 1 < maxX &&
      dings[valueY][valueX + 1] <= currentValue + 1 &&
      !visited.include?([valueX+1, valueY]*",")
    ) then
      adjacent << ([valueX+1, valueY,counter])
    end

    queue.push(*adjacent)
  end
end
end
  }
}

puts minnestMin
