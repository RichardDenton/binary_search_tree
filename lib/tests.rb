require_relative 'Tree'
insert = 0

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
test.pretty_print
puts "Insert #{insert}"
test.insert(insert)
puts
test.pretty_print
puts "Delete 5"
test.delete(5)
test.pretty_print
puts "Delete 1"
test.delete(1)
test.pretty_print
puts "Insert 300 and 305"
test.insert(300)
test.insert(305)
test.pretty_print
puts "Delete 67"
test.delete(67)
test.pretty_print
puts "Delete 8"
test.delete(8)
test.pretty_print

test2 = Tree.new([1,2])
test2.pretty_print
test2.delete(1)
test2.pretty_print
test2.delete(2)
test2.pretty_print