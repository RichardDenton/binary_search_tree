# Driver script for testingthe binary ssearch tree
require_relative 'Tree'

elements = Array.new(15) { rand(1..100) }
tree = Tree.new(elements)
tree.pretty_print
puts ("Balanced: " + tree.balanced?.to_s)
puts ("\nPreorder")
puts (tree.preorder)
puts ("\nInorder")
puts (tree.inorder)
puts ("\nPostorder")
puts (tree.postorder)
puts ("\nUnbalancing tree...")
tree.insert(110)
tree.insert(120)
tree.insert(130)
tree.insert(140)
puts ("Balanced: " + tree.balanced?.to_s)
puts ("\nBalancing tree...")
tree.rebalance
puts ("Balanced: " + tree.balanced?.to_s)
tree.pretty_print
puts ("\nPreorder")
puts (tree.preorder)
puts ("\nInorder")
puts (tree.inorder)
puts ("\nPostorder")
puts (tree.postorder)