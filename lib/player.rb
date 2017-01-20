require_relative 'board.rb'
require_relative 'translator.rb'
require_relative 'messages.rb'

class Player
	include Message
	include Translator

	attr_accessor :hit, :win

	def initialize
		@hit = false
	end

	def check_coordinates?
		output.count == 4
	end

	def place_ship_1(board, coordinates)
		translate(coordinates)
		if	check_coordinates? && check_destroyer_placement?(board, pos_1, pos_2, pos_3, pos_4)
			 		board[pos_1][pos_2] = 'd'
			 		board[pos_3][pos_4] = 'd'
		end
	end

	def check_row_and_column?(pos_1, pos_2, pos_3, pos_4)
		pos_1 == pos_3 || pos_2 == pos_4
	end 

	def check_destroyer_continuity?(pos_1, pos_2, pos_3, pos_4)
		(pos_1 + 1) == pos_3 || (pos_2 + 1) == pos_4
	end

	def check_destroyer_path?(board, pos_1, pos_2, pos_3, pos_4)
		board[pos_1][pos_2] == '0' && board[pos_3][pos_4] == '0'
	end

	def check_destroyer_placement?(board, pos_1, pos_2, pos_3, pos_4)
		check_row_and_column?(pos_1, pos_2, pos_3, pos_4) && 
		check_destroyer_continuity?(pos_1, pos_2, pos_3, pos_4) && 
		check_destroyer_path?(board, pos_1, pos_2, pos_3, pos_4)
	end

	def place_ship_2(board, input)
		translate(input)
		if check_coordinates? && check_submarine_placement?(board, pos_1, pos_2, pos_3, pos_4) 
				board[pos_1][pos_2] = 's'
				board[pos_3][pos_4] = 's'
				middle_space(board, pos_1, pos_2, pos_3, pos_4)
		end
	end

	def middle_space(board, pos_1, pos_2, pos_3, pos_4)
		case
			when (pos_1 + 2) == pos_3
				board[pos_1 + 1][pos_2] = 's'
			when (pos_2 + 2) == pos_4
				board[pos_1][pos_2 + 1] = 's'
			end
	end

	def check_submarine_continuity?(pos_1, pos_2, pos_3, pos_4)
		(pos_1 + 2) == pos_3 || (pos_2 + 2 ) == pos_4
	end

	def check_beginning_end?(board, pos_1, pos_2, pos_3, pos_4)
		board[pos_1][pos_2] == '0' && board[pos_3][pos_4] == '0'
	end

	def check_submarine_path?(board, pos_1, pos_2, pos_3, pos_4)
		case
			when (pos_1 + 2) == pos_3
				board[pos_1 + 1][pos_2] == '0'
			when (pos_2 + 2) == pos_4
				board[pos_1][pos_2 + 1] == '0'
		end
	end

	def check_submarine_placement?(board, pos_1, pos_2, pos_3, pos_4)
		check_row_and_column?(pos_1, pos_2, pos_3, pos_4) &&
		check_beginning_end?(board, pos_1, pos_2, pos_3, pos_4) &&
		check_submarine_continuity?(pos_1, pos_2, pos_3, pos_4) &&
		check_submarine_path?(board, pos_1, pos_2, pos_3, pos_4)
	end

	def shoot(board, input)
		translate(input)
		check_hit?(board,pos_1,pos_2) ? bang(board, pos_1, pos_2) : miss
	end

	def check_hit?(board,pos_1,pos_2)
		board[pos_1][pos_2] != '0'
	end

	def bang(board,pos_1,pos_2)
		board[pos_1][pos_2] = '0'
		@hit = true
	end
			
	def miss
		@hit = false
	end

	def win?(board)
		check_board?(board) ? (@win=false) : (@win=true)
	end

	def check_board?(board)
	 board.flatten.include?("d") || board.flatten.include?("s")
	end
	
end 

			
