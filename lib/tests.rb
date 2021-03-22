require_relative 'Tree'
insert = 0

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
test.pretty_print
puts "Insert #{insert}"
test.insert(insert)
puts
test.pretty_print
test.delete(5)
test.pretty_print
test.delete(9)
test.pretty_print