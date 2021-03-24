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
    return if node.data != value
    
    predecessor = get_predecessor(node)
    
    # Delete the node if it is a leaf node
    if node.number_of_children == 0
      predecessor.left = nil if predecessor.left == node
      predecessor.right = nil if predecessor.right == node
      @root = nil if @root == node
      return
    end

    # Delete if one child
    if node.number_of_children == 1
      child = node.left if !node.left.nil?
      child = node.right if !node.right.nil?
      predecessor.left = child if predecessor.left == node
      predecessor.right = child if predecessor.right == node
      @root = child if @root == node
      return
    end

    # Delete if two children
    if node.number_of_children == 2
      next_smallest = get_smallest_child(node.right)
      next_smallest_predecessor = get_predecessor(next_smallest)
      # Handle case where next_smallest has no child nodes
      if next_smallest.number_of_children == 0
        next_smallest.left = node.left if node.left != next_smallest
        next_smallest.right = node.right if node.right != next_smallest
        next_smallest_predecessor.left = nil if next_smallest_predecessor.left = next_smallest
        next_smallest_predecessor.right = nil if next_smallest_predecessor.right = next_smallest
        predecessor.left = next_smallest if predecessor.left == node
        predecessor.right = next_smallest if predecessor.right == node
        @root = next_smallest if @root == node
        return
      end
      # Handle case where next_smallest has a child
      if next_smallest.number_of_children > 0
        next_smallest_predecessor.left = next_smallest.right
        next_smallest.left = node.left if node.left != next_smallest
        next_smallest.right = node.right if node.right != next_smallest
        predecessor.left = next_smallest if predecessor.left == node
        predecessor.right = next_smallest if predecessor.right == node
        @root = next_smallest if @root == node
        return
      end
    end
    
  end

  def find(value)
    search_result = search(value)
    return search_result if search_result.data == value
    return nil
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    if @root.nil?
      puts "Empty tree"
      return
    end
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private
  # Returns the node searched for or its parent leaf is the node does not exist
  def search(value, node = @root)
      return node if value < node.data and node.left.nil?
      return node if value > node.data and node.right.nil?
      return node if value == node.data
      
      return search(value, node.left) if value < node.data
      return search(value, node.right) if value > node.data
  end

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