
class Queen

    attr_reader :board, :num_queens, :queens, :solved

	def initialize

     @board = Array.new(8) { Array.new(8) }
     @all_positions = []
     @solved = []
     @stop = [[0,0],[0,1],[0,2],[0,3], [0,4], [0,5], [0,6], [0,7]]

     all
	end

    def all
 	  (0..7).each do |row|
    	(0..7).each do |col|
    	  @all_positions << [row,col]
    	 end
      end
    end

    def deep_dup(obj)
      obj.map(&:dup)
    end

    def print_(board)
      print "\n"
	  board.each do |row|
	   line = ""
    	 row.each do |el| 
		   line += "_" if el.nil?
		   line += "Q" if el == "Q"
			 end
		  puts line
		end
	  nil
    end
     
    def start
      place_queen(deep_dup(@board), [])
    end

    def find_queens(board)
      queens = []
      (0..7).each do |row|
        (0..7).each do |col|
            queens << [row,col] if board[row][col] == "Q"
        end
      end

      blocked = []
      queens.each do |queen_spot|
        moves(queen_spot).each do |spot|
          blocked << spot unless blocked.include?(spot)
        end
      end
      blocked
    end
    
    def how_many(board)
        board.flatten.compact.count
    end


    def place_queen(board, vp)

        print_(board)
  
        available = @all_positions - vp

        if vp.count >= 8 && vp.sort.first(8) == @stop && board.first.all? { |el| el.nil?}  
        elsif available.count != 0
          available.each do |spot|
              this_board = deep_dup(board)
              next if vp.include?([spot[0],spot[1]])
              this_board[spot[0]][spot[1]] = "Q"
              
              vp2 = deep_dup(@all_positions[0..(@all_positions.index([spot[0],spot[1]]))])
              vp3 = deep_dup(vp)
              vp3 += vp2 + moves([spot[0], spot[1]])
              vp3.uniq!
              @solved << this_board if how_many(this_board) == 8
              place_queen(deep_dup(this_board), deep_dup(vp3))
            end
        end
     nil
    end

    def valid?(pos)
    	pos[0] >= 0 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 8 
    end

    def moves(pos)
    	directions = [ [0, 1] , [0, -1], [1, 0], [-1, 0],
    				   [1, 1] , [1, -1], [-1, 1], [-1, -1]]
        visited = Array.new
        directions.each do |delta|
    		pos2 = pos.dup
    		while valid?(pos2)
                visited << pos2.dup unless visited.include?(pos2)
    			pos2[0] += delta[0]
    			pos2[1] += delta[1]	
    		end
    	end
    	visited
    end

    def inspect
    end

end
