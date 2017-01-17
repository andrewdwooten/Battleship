class Board
attr_reader		:letters
attr_accessor :player_board, 
			  			:computer_board, 
			  			:display_board

	def initialize
		@player_board   = Array.new(4){Array.new(4,'0')}
		@computer_board = Array.new(4){Array.new(4,'0')}
		@display_board  = Array.new(4){Array.new(4," ")}
		@letters = ['A','B','C','D']
	end

	def display
		heading
		subheading
		build_board
	end

	def build_board
		@display_board.each.with_index do |row,index| 
			print letters[index] + " :"; row.each do |space|
			print "|" + space + '|:' end; print "\n"; subheading end
	end

	def heading
		puts '.   1   2   3   4'
	end

	def subheading
		puts '==================='
	end	

end