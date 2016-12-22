class Board
attr_accessor :player_board, 
			  :computer_board, 
			  :display_board

	def initialize
		@player_board   = Array.new(4){Array.new(4,'0')}
		@computer_board = Array.new(4){Array.new(4,'0')}
		@display_board  = Array.new(4){Array.new(4," ")}
	end

	def pretty
		letters = ['A','B','C','D']
		puts '.  1 2 3 4'
		puts '=========='
		@display_board.each.with_index do |row,index| 
			print letters[index] + "  "; row.each do |space|
			print space + " " end; print "\n" end
	end
end