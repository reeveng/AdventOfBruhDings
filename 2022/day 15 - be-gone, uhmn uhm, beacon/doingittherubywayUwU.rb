require 'set'

# .lines(chomp: true) = split on line endings (kind of)
dings = File.read("input.txt").lines(chomp: true).filter_map{|x|
  sensorCol,sensorRow,beaconCol,beaconRow=x.scan(/-?\d+/).map(&:to_i)
  [[sensorCol,sensorRow],[beaconCol,beaconRow]]
}
# print dings
minCol, maxCol = dings.flat_map{a,b = _1;[a[0],b[0]]}.minmax
minRow, maxRow = dings.flat_map{a,b = _1;[a[1],b[1]]}.minmax

# # -------------------------------
# # part 1
# # -------------------------------
# wantedRow=Set.new
# beacons=Set.new
# sensors=Set.new

# wantedRowValue=2000000

# dings.each{|points|
#   (sensorCol,sensorRow),(beaconCol,beaconRow)=points;
#   distance=(sensorRow-beaconRow).abs + (sensorCol-beaconCol).abs

#   if(wantedRowValue==sensorRow)then
#     wantedRow<<sensorCol
#   end
#   if(wantedRowValue==beaconRow)then
#     beacons<<beaconCol
#   end

#   (sensorCol-distance-1..sensorCol+distance+1).each{|columnCoordinateInRow|
#     currentThing = (sensorRow-wantedRowValue).abs + (columnCoordinateInRow-sensorCol).abs
#     if (currentThing <= distance) then
#       wantedRow<<columnCoordinateInRow
#     end
#   }
# }

# puts (wantedRow-beacons).size



# # -------------------------------
# # part 2
# # -------------------------------

# yoinked code from geeks for geeks
def mergeIntervals(intervals)
  intervals = intervals.sort_by{_1[0]}
  stack = [intervals[0]]
  for i in intervals do
      if (stack[-1][0] <= i[0] && i[0] <= stack[-1][-1]) then
          stack[-1][-1] = [stack[-1][-1], i[-1]].max
      else
          stack << i
      end
  end

  return stack
end

(0..4000000).each{|row|
  intervals=[]
  dings.each{|points|
    (sensorCol,sensorRow), (beaconCol,beaconRow) = points;
    distance = (sensorRow-beaconRow).abs + (sensorCol-beaconCol).abs

    horizontaldistance = distance - (sensorRow-row).abs
    if (horizontaldistance >= 0) then
      intervals << [sensorCol - horizontaldistance, sensorCol + horizontaldistance + 1]
    end
  }

  mergedIntervalsDing = mergeIntervals(intervals)
  if (mergedIntervalsDing.size >= 2) then
    puts row
    puts mergedIntervalsDing.map{_1*", "}
    exit
  end
}

# puts 2634249+3120101*4000000
