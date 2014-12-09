require 'debugger'
require './tree_node.rb'

class KnightPathFinder
  def initialize(start_pos)
    @start_pos = start_pos
    @end_node = nil
    @visited_positions = [start_pos]
    @start_node = nil
    @node_tree = nil
  end
  
  def find_path(end_pos)
    @end_node = build_move_tree.bfs(end_pos)
    trace_path_back
  end
  
  def trace_path_back
    finished = false
    node = @start_node
    path = []
    until node.parent == nil
      path.unshift(node.value)
      node.parent == nil ? break : node = node.parent 
    end
    path.unshift(@start_node.value)    
  end

  def valid_moves(pos)
    move = []
    directions = [[1,2], [1,-2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    directions.each do |delta|
      temp_pos = pos.dup
      temp_pos[0] += delta[0]
      temp_pos[1] += delta[1]
      move << temp_pos
    end
    move.select do |el|
      el[0] < 8 && el[1] < 8 && el[0] >= 0 && el[1] >=0
    end             
  end
  
  def new_move_positions(pos)
    valid_moves(pos) - @visited_positions
  end
  
  def build_move_tree 
    @start_node = PolyTreeNode.new(@start_pos)    
    queue = new_move_positions(@start_pos)
    node_tree = [@start_node]
    @visited_positions = [@start_pos]
    until node_tree.empty?
      result = node_tree.shift
      queue = new_move_positions(result.value)
      queue.each do |current_pos|
        @visited_positions << current_pos       
        new_move_positions(current_pos)      
        node = PolyTreeNode.new(current_pos)
        node.parent = (result)
        node_tree << node
      end
    end
    @start_node
  end
end

knight = KnightPathFinder.new([0,0])
p knight.find_path([7,6])
p knight.find_path([6,2])
p knight.find_path([2,1])
p knight.find_path([7,7])








