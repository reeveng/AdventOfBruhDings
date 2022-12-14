require 'set'

# .lines(chomp: true) = split on line endings (kind of)
dings = File.read("input.txt").lines(chomp: true).filter_map{|x|
  eval(x)
}
# dings.each_slice(2).map{puts [_1*'',_2*'']*" "}

dings=dings

# # -------------------------------
# # part 1
# # -------------------------------
# def recursionDing(a,b)
#   aIsInt=(a.is_a? Integer)
#   bIsInt=(b.is_a? Integer)

#   if (aIsInt && bIsInt) then
#     return a <=> b
#   elsif (a.nil? || b.nil?) then
#     return b.nil? ? 1 : -1
#   elsif ((!aIsInt&& a.empty?) || (!bIsInt && b.empty?)) then
#     if ((!bIsInt && b.empty?)) then
#       return 1
#     else
#       return -1
#     end
#   else
#     if (aIsInt) then
#       a=[a]
#     end
#     if (bIsInt) then
#       b=[b]
#     end

#     idkwhatyouareyet = a.each_with_index.map{ recursionDing(_1,b[_2]) }.reject{_1==0}

#     return idkwhatyouareyet.first || a.size<=>b.size || 0
#   end
# end
def recursionDing(a,b)
  aIsInt=(a.is_a? Integer)
  bIsInt=(b.is_a? Integer)

  if (aIsInt && bIsInt) then
    return a <=> b
  else
    if (aIsInt) then
      a=[a]
    end
    if (bIsInt) then
      b=[b]
    end

    if(b.nil?)then
      return 1
    end
    if(a.nil?)then
      return -1
    end

    values = a.zip(b).map{
      recursionDing(_1,_2)
    }
    return values.reject{_1==0}.first || a.size <=> b.size || 0
  end
end

# puts dings.each_with_index.sum{|ding,index|
#   a,b=ding
#   recursionDing(a,b) <= 0 ? index+1 : 0
# }


# # -------------------------------
# # part 2
# # -------------------------------
dings = dings.sort{|a,b|
  recursionDing(a,b)
}

puts (dings.index([[2]])+1)*(dings.index([[6]])+1)

