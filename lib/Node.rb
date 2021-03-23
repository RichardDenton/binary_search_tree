class Node
  include Comparable
  attr_reader :data
  attr_accessor :left, :right
  
  def <=>(other_node)
    data <=> other_node.data
  end
  
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def number_of_children
    count = 0
    count += 1 if !self.left.nil?
    count += 1 if !self.right.nil?
    return count
  end
end