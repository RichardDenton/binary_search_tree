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
end