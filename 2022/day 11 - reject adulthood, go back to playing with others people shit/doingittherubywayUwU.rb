monkeys = `cat input.txt`.split("\n\n").map{|x|
  a,b,c,*d=x.split("\n").map{_1.strip}
  {
    "id"=> a.scan(/\d+/)[0].to_i,
    "items" => b.split(?:)[1].split(?,).map(&:to_i),
    "operation" => c.split(?:)[1].gsub("new = "){}.strip,
    "test" => d.join.scan(/\d+/).map(&:to_i),
    "inspected" => 0,
  }
}
puts monkeys

# part 1
# 20.times{
#   puts _1
#   monkeys.each{|monkey|
#     id=monkey["id"]
#     items=monkey["items"]
#     operation=monkey["operation"]
#     test=monkey["test"]
#     inspected=monkey["inspected"]

#     items.each{|itemValue|
#       value = (eval(operation.gsub("old"){itemValue})/3).to_i
#       monkeys[
#         value % test[0] == 0 ? test[1] : test[2]
#       ]["items"].push(value)
#     }
#     monkeys[id]["inspected"] += items.size
#     monkeys[id]["items"] = []
#   }
# }
# a,b=monkeys.sort_by{_1["inspected"]}[-2..]
# puts a["inspected"]*b["inspected"]


# part 2
multiplyingthedivisors = eval(monkeys.map{_1["test"][0]}*"*")

10000.times{
  monkeys.each{|monkey|
    id=monkey["id"]
    items=monkey["items"]
    operation=monkey["operation"]
    test=monkey["test"]
    inspected=monkey["inspected"]

    items.each{|itemValue|
      value = (eval(operation.gsub("old"){itemValue}))
      value %= multiplyingthedivisors
      monkeys[
        value % test[0] == 0 ? test[1] : test[2]
      ]["items"].push(value)
    }
    monkeys[id]["inspected"] += items.size
    monkeys[id]["items"] = []
  }
}

a,b=monkeys.sort_by{_1["inspected"]}[-2..]
puts a["inspected"]*b["inspected"]
