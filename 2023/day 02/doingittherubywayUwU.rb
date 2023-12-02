require 'set'

# .lines(chomp: true) = split on line eninputdings (kind of)
inputdings = File.read("input.txt").lines(chomp: true).filter_map{|x|
  x
}

# # -------------------------------
# # part 1
# #
# # find sum of id's for possible games
# # -------------------------------

# # [R, G, B]
cannotgoabovethesebruh = [12, 13, 14]

p inputdings.sum{|text|
  text.split(?;).all?{|section|
    otherbruh = [
      section.scan(/\d+ red/i).sum{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
      section.scan(/\d+ green/i).sum{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
      section.scan(/\d+ blue/i).sum{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
    ]

    allsmaller = otherbruh.zip(cannotgoabovethesebruh).all?{|a,b|
      a <= b
    }

    allsmaller
  } ? text.scan(/\d+/).first.to_i : 0
}

p inputdings.sum{|text|
  otherbruh = [
    text.scan(/\d+ red/i).sum{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
    text.scan(/\d+ green/i).sum{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
    text.scan(/\d+ blue/i).sum{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
  ]

  allsmaller = otherbruh.zip(cannotgoabovethesebruh).all?{|a,b|
    a <= b
  }

  allsmaller ? text.scan(/\d+/).first.to_i : 0
}

# # -------------------------------
# # part 2
# # -------------------------------

p inputdings.sum{|text|
  otherbruh = [
    text.scan(/\d+ red/i).map{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
    text.scan(/\d+ green/i).map{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
    text.scan(/\d+ blue/i).map{|numberwithtext| numberwithtext.scan(/\d+/).first.to_i},
  ]

  eval otherbruh.map{|cock| [1, *cock].max}*?*
}
