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
    node = find(value)
    return if node.nil?

    children = node.number_of_children
    delete_0_children(node) if children == 0
    delete_1_child(node) if children == 1
    delete_2_children(node) if children == 2
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

  def level_order(queue = [@root], data_array = [])
    node = queue.shift
    return data_array if node.nil?

    data_array.push(node.data)
    queue.push(node.left) if !node.left.nil?
    queue.push(node.right) if !node.right.nil?
    return level_order(queue, data_array)
  end

  def preorder(node = @root, data_array = [])
    return data_array if node.nil?
    data_array.push(node.data)
    preorder(node.left, data_array)
    preorder(node.right, data_array)
  end

  def inorder(node = @root, data_array = [])
    return data_array if node.nil?
    inorder(node.left, data_array)
    data_array.push(node.data)
    inorder(node.right, data_array)
  end

  def postorder(node = @root, data_array = [])
    return data_array if node.nil?
    postorder(node.left, data_array)
    postorder(node.right, data_array)
    data_array.push(node.data)
  end

  def height(node)
    return -1 if node.nil?
    left_height = height(node.left)
    right_height = height(node.right)

    if left_height > right_height
      return (left_height + 1)
    else
      return (right_height + 1)
    end
  end

  def depth(node, current_node = @root, level = 0)
    return 0 if node.nil?
    return level if current_node == node
      
    return depth(node, current_node.left, level += 1) if node < current_node
    return depth(node, current_node.right, level += 1) if node > current_node
  end

  def balanced?(node = @root)
    # Check if lefty and right subtrees of node are balanced
    if height(node.left) - height(node.right) >= 0
      height_dif = height(node.left) - height(node.right)
    elsif height(node.right) - height(node.left) >= 0
      height_dif = height(node.right) - height(node.left)
    end
    balanced = height_dif < 2
    return balanced if !balanced

    balanced = balanced?(node.left) if balanced and !node.left.nil?
    balanced = balanced?(node.right) if balanced and !node.right.nil?
    return balanced
  end

  def rebalance
    new_tree = Tree.new(inorder)
    @root = new_tree.root
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

  def delete_0_children(node)
    predecessor = get_predecessor(node)
    predecessor.left = nil if predecessor.left == node
    predecessor.right = nil if predecessor.right == node
    @root = nil if @root == node
    return
  end

  def delete_1_child(node)
    predecessor = get_predecessor(node)
    child = node.left if !node.left.nil?
    child = node.right if !node.right.nil?
    predecessor.left = child if predecessor.left == node
    predecessor.right = child if predecessor.right == node
    @root = child if @root == node
    return
  end

  def delete_2_children(node)
    predecessor = get_predecessor(node)
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