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

  def insert(value)
    node = search(value)
    return nil unless node.data != value
    new_node = Node.new(value)
    node.left = new_node if new_node < node
    node.right = new_node if new_node > node
  end

  def delete(value)
    node = search(value)
    return if node.nil?
    
    predecessor = get_predecessor(node)
    
    # Delete the node if it is a leaf node
    if node.is_leaf?
      predecessor.left = nil if predecessor.left == node
      predecessor.right = nil if predecessor.right == node
      return
    end

    # Delete if one child
    if node.left.nil? or node.right.nil?
      child = node.left if !node.left.nil?
      child = node.right if !node.right.nil?
      predecessor.left = child if predecessor.left == node
      predecessor.right = child if predecessor.right == node
      return
    end

    # Delete if two children
    next_smallest = get_smallest_child(node.right)
    
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # Returns the node searched for or its parent leaf is the node does not exist
  def search(value, node = @root)
      return node if value < node.data and node.left.nil?
      return node if value > node.data and node.right.nil?
      return node if value == node.data
      
      return search(value, node.left) if value < node.data
      return search(value, node.right) if value > node.data
  end

  # private

  def get_predecessor(search_node, current_node = @root)
    return current_node if current_node.left == search_node or current_node.right == search_node
    return search_node if search_node == @root
    
    return get_predecessor(search_node, current_node.left) if search_node < current_node
    return get_predecessor(search_node, current_node.right) if search_node > current_node
  end

  def get_smallest_child(node)
    return node if node.left.nil?
    return get_smallest_child(node.left)
  end

end