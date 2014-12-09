class PolyTreeNode
  
  attr_reader :value, :parent, :children
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent= (node = nil)
    if @parent == nil
      @parent = node
      node.children << self unless node == nil || node.children.include?(self)
    else
      @parent.children.delete(self)
      @parent = node
      node.children << self unless node == nil || node.children.include?(self)
    end
  end
  
  def add_child(child_node)
    child_node.parent=(self)
  end
  
  def remove_child(child_node)
    raise "ERROR" unless self.children.include?(child_node)
    child_node.parent=(nil)
  end
  
  def dfs(value)
    return self if @value == value
    @children.each do |child|
      result = child.dfs(value)
      next if result == nil
      return result
    end
    nil
  end
  
  def bfs(value)
    return self if @value == value
    queue = [self]
    until queue.empty?
      result = queue.shift
      return result if result.value == value
      queue += result.children
    end
    nil
  end
end
