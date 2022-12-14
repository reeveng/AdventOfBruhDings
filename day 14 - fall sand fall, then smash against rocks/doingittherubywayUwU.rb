require 'set'

# .lines(chomp: true) = split on line endings (kind of)
dings = File.read("input.txt").lines(chomp: true).filter_map{|x|
  x.split("->").map{|t|t.split(?,).map{_1.to_i}}
}
# print dings

# find max and min for matrix ding
(minX,maxX),(minY,maxY)=[*dings.flatten(1),[500,0]].transpose.map(&:minmax)

# # -------------------------------
# # part 1
# # -------------------------------
# grid = (minY..maxY).map{
#   (minX..maxX).map{?.}*""
# }

# dings.each{|coordinatesOfSpecialShapeThing|
#   currentXY=[*coordinatesOfSpecialShapeThing[0]]
#   currentIndex=1

#   # while the current is not at the end draw hashtags
#   while(currentIndex < coordinatesOfSpecialShapeThing.size) do
#     x,y=currentXY
#     # if the coordinates are at the next item change direction? maybe
#     if(currentXY == coordinatesOfSpecialShapeThing[currentIndex])then
#       currentIndex+=1
#     end
#     grid[maxY-y][x]=?#

#     # calculate the way, left right up down the shape goes
#     endGoalForLineX,endGoalForLineY=coordinatesOfSpecialShapeThing[currentIndex]

#     currentXY=[x+(endGoalForLineX<=>x),y+(endGoalForLineY<=>y)] if coordinatesOfSpecialShapeThing[currentIndex]
#   end
#   x,y=currentXY

#   grid[maxY-y][x]=?#
#   grid[maxY-0][500]=?*
# }

# grid=grid.map{_1.chars}.map{_1.reverse*""}.reverse
# puts grid


# # time to start playing with sand
# rowMax=grid[0].size
# columnMax=grid.size

# row=0
# column=grid[0].index(?*)

# startingColumn=column
# startingRow=row
# count=0

# def downleftright(grid, row, column)
#   if (grid[row+1][column] == ?.) then
#     return [row+1,column]
#   elsif (grid[row+1][column-1] == ?.) then
#     return [row+1,column-1]
#   elsif (grid[row+1][column+1] == ?.) then
#     return [row+1,column+1]
#   else
#     return [row,column]
#   end

# end
# puts grid
# while(
#   (row <= rowMax || row >= 0) &&
#   (column <= columnMax || column >= 0)
#   ) do

#   continue=true
#   while (continue) do
#     newrow,newcolumn=downleftright(grid,row,column)

#     if ((newrow==row&&newcolumn==column)) then
#       grid[row][column]=?o
#       count+=1
#       continue=false
#       # puts grid
#     else
#       row,column=[newrow,newcolumn]
#     end
#   end

#   p count
#   row=startingRow
#   column=startingColumn
# end

# puts grid
# # -------------------------------
# # part 2
# # -------------------------------

grid = (minY..maxY).map{
  (minX-1000..maxX+1000).map{?.}*""
}

dings.each{|coordinatesOfSpecialShapeThing|
  currentXY=[*coordinatesOfSpecialShapeThing[0]]
  currentIndex=1

  # while the current is not at the end draw hashtags
  while(currentIndex < coordinatesOfSpecialShapeThing.size) do
    x,y=currentXY
    # if the coordinates are at the next item change direction? maybe
    if(currentXY == coordinatesOfSpecialShapeThing[currentIndex])then
      currentIndex+=1
    end
    grid[maxY-y][x]=?#

    # calculate the way, left right up down the shape goes
    endGoalForLineX,endGoalForLineY=coordinatesOfSpecialShapeThing[currentIndex]

    currentXY=[x+(endGoalForLineX<=>x),y+(endGoalForLineY<=>y)] if coordinatesOfSpecialShapeThing[currentIndex]
  end
  x,y=currentXY

  grid[maxY-y][x]=?#
  grid[maxY-0][500]=?*
}

grid=grid.map{_1.chars}.map{_1.reverse*""}.reverse
grid=grid.push(?.*grid[0].size).push(?#*grid[0].size)


# time to start playing with sand
rowMax=grid[0].size
columnMax=grid.size

row=0
column=grid[0].index(?*)

startingColumn=column
startingRow=row
count=0

def downleftright(grid, row, column)
  if (grid[row+1][column] == ?.) then
    return [row+1,column]
  elsif (grid[row+1][column-1] == ?.) then
    return [row+1,column-1]
  elsif (grid[row+1][column+1] == ?.) then
    return [row+1,column+1]
  else
    return [row,column]
  end

end
# puts grid
while(
  downleftright(grid,row,column)!=[startingRow,startingColumn]
  ) do

  continue=true
  while (continue) do
    newrow,newcolumn=downleftright(grid,row,column)

    if ((newrow==row&&newcolumn==column)) then
      grid[row][column]=?o
      count+=1
      continue=false
      # puts grid
    else
      row,column=[newrow,newcolumn]
    end
  end

  row=startingRow
  column=startingColumn
end
p count


# puts grid
