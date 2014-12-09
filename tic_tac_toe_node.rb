require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @children = []
    @parent = nil
    @prev_move_pos = prev_move_pos
  end
  
  def parent
    @parent
  end
  
  def prev_move_pos
    @prev_move_pos 
  end
  
  def board
    @board
  end

  def next_mover_mark
    @next_mover_mark
  end
  
  def losing_node?(evaluator)
    return true if @board.won? && @board.winner != evaluator
    a = []
    self.children.each do |child|    
      a << child.losing_node?(evaluator)
    end
    a.any? do |el|
      return true if el == true
    end
    false
  end

  def winning_node?(evaluator)
    return true if @board.over? && @board.winner == evaluator
    if @board.over? && (@board.winner != evaluator || @board.winner == nil)
      return false
    end
    if evaluator == next_mover_mark
      return children.any? do |child|
        child.winning_node?(evaluator) == false
      end
    else
      return children.all? do |child|
        child.winning_node?(next_mover_mark) == true
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def parent=(node)
    if self.parent == nil
      @parent = node
      node.children << self unless node == nil || node.children.include?(self)
    else
      self.parent.children.delete(self)
      @parent = node
      node.children << self unless node == nil || node.children.include?(self)
    end
  end
  
  def children
    array = []
    @board.rows.each_with_index do |row, idx|
      row.each_with_index do |pos, j|
        if pos == nil
          new_board = @board.dup
          mark = next_mover_mark
          mark == :x ? mark = :o : mark = :x
          new_board[[idx, j]] = mark      
          possibility = TicTacToeNode.new(new_board, mark, [idx, j])
          array << possibility
        end
      end
    end
    @children = array
    array
  end
end


