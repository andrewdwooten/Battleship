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

	def place_ship_1(board, coordinates)
		Translator.translate(coordinates)
		pos_1 = Translator.pos_1
		pos_2 = Translator.pos_2
		pos_3 = Translator.pos_3
		pos_4 = Translator.pos_4

		if [pos_1, pos_2, pos_3, pos_4].include?(nil) == true
				Message.invalid_placement
			
		elsif	 [pos_1 == pos_3 || pos_2 == pos_4] && 
		 	 		 [pos_1 == (pos_3 + 1)] || [pos_2 == (pos_4 + 1)] && 
		 	 		 [board[pos_1][pos_2]] == '0' && [board[pos_2][pos_4]] == '0'  

			 		 board[pos_1][pos_2] = 'd'
			 		 board[pos_3][pos_4] = 'd'
		else
			Message.invalid_placement
		end
	end

	def place_ship_2(board, coordinates)
		Translator.translate(coordinates)
		pos_1 = Translator.pos_1
		pos_2 = Translator.pos_2
		pos_3 = Translator.pos_3
		pos_4 = Translator.pos_4

		if [pos_1, pos_2, pos_3, pos_4].include?(nil) == true
				Message.invalid_placement
			
		elsif [pos_1 == pos_3 || pos_2 == pos_4] &&
				  [pos_1 == (pos_3 + 1) || pos_2 == (pos_4 + 1)] &&
					[board[pos_1][pos_2] == '0' && board[pos_2][pos_4]== '0'] &&  
			
					board[pos_1][pos_2] = 's'
					board[pos_3][pos_4] = 's'

					if [pos_1 = pos_3] && board[pos_1][pos_2 + 1] == '0'
				 		 board[pos_1][pos_2 + 1] = 's'
					else
				 	board[pos_1 + 1][pos_3] = 's'
					end
				
		else
			Message.invalid_placement
		end
	  end

	def shoot(board, input)
		Translator.translate(input)
		if board[Translator.pos_1][Translator.pos_2] != '0'
			 	board[Translator.pos_1][Translator.pos_2] = '0'
			 	puts Message.hit
				@hit = true
		else
			 puts Message.miss
			 @hit = false
		end
	end

	def win?(board)
		if board.flatten.include?("d") || board.flatten.include?("s")
			@win = false
		else
			@win = true
		end
	end
end

			
