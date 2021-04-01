# Binary Search Tree
A Binary Search Tree implemented in Ruby as part of the [Odin Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/binary-search-trees) curriculum.

## Methods
The data structure has the following methods:
* build_tree -Accepts an array of data and builds a binary search tree with it.
* insert - Accepts a value and inserts this into the tree
* delete - Accepts a value and deletes it from the tree if it is present
* find - Accepts a value and returns the node with that value if it is present
* level_order - Prints out the values of each node in level order
* inorder - Prints out the values of each node in inorder order
* preorder - Prints out the values of each node in preorder order
* postorder - Prints out the values of each node in postorder order
* height - Accepts a node and returns the height of the node
* depth - Accepts a node and returns the depth of the node
* balanced? - Checks if the tree is balanced
* rebalance - Rebalances the tree

## Running the demonstration
/lib/driver.rb is a script that runs a series of tests to demonstrate the data structure. The script does the following:
1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
2. Confirm that the tree is balanced by calling `#balanced?`
3. Print out all elements in level, pre, post, and in order
4. try to unbalance the tree by adding several numbers > 100
5. Confirm that the tree is unbalanced by calling `#balanced?`
6. Balance the tree by calling `#rebalance`
7. Confirm that the tree is balanced by calling `#balanced?`
8. Print out all elements in level, pre, post, and in order