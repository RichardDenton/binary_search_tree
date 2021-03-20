require_relative 'Tree'
insert = 24

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
test.pretty_print
puts "Insert #{insert}"
test.insert(insert)
puts
test.pretty_print