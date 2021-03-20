require_relative 'Node'

class Tree
  attr_reader :root
  def initialize(num_array)
    @data = num_array.uniq.sort
    @root = build_tree(@data)
  end

  def build_tree(num_array, start_index = 0, last_index = num_array.length - 1)
    return nil if start_index > last_index
    mid_index = (start_index + last_index) / 2
    node = Node.new(num_array[mid_index])
    node.left = build_tree(num_array, start_index, mid_index - 1)
    node.right = build_tree(num_array, mid_index + 1, last_index)
    return node
  end

  # Gets the leaf not to use as a parent for insertion
  def get_parent_leaf(value, node = @root)
    return node if value < node.data and node.left.nil?
    return node if value > node.data and node.right.nil?
    
    return get_parent_leaf(value, node.left) if value < node.data
    return get_parent_leaf(value, node.right) if value > node.data
  end

  def insert(value)
    node = get_parent_leaf(value)
    new_node = Node.new(value)
    node.left = new_node if new_node < node
    node.right = new_node if new_node > node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end