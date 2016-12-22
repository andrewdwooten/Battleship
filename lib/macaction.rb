require_relative 'board.rb'
require_relative 'messages.rb'

class MacAction
include Message
	attr_reader :a, :b
	attr_accessor :win
	
  def initialize
  end

	def place_ships(board, ship)
		@a = rand(4)
		@b = rand(4)
			if board[@a][@b] == '0'
				board[@a][@b] = ship[0]; 
				case 
				when board[@a][@b + 1] == '0' && board[@a][@b + 2] == '0'
					board[@a][@b + 1] = ship[1]
					if ship[2] != nil; board[@a][@b + 2] = ship[2]
					end
				when board[@a][@b - 1] == '0' && board[@a][@b - 2] == '0'
					board[@a][@b -1] = ship[1]
					if ship[2] != nil; board[@a][@b - 2] = ship[2]
					end
				when board[@a + 1][@b] == '0' && board[@a + 2][@b] == '0'
					board[@a + 1][@b] = ship[1]
					if ship[2] != nil; board[@a +2] = ship[2]
					end
				when board[@a - 1][@b] == '0' && board[@a - 2][@b] == '0'
					board[@a - 1][@b] = ship[1]
					if board[2] != nil; board[@a-2][@b] = ship[2]
					end
				end
			else
			end
		end

		def shoot(board)
			if board[@a][@b] != '0'
				board[@a][@b] = '0'
				puts Message.computer_hit
			else
				puts Message.computer_miss
			end
		end

		def win?(board)
		 	if board.flatten.include?("d") || board.flatten.include?("s")
			 	@win = false
			else
				@win =  true
			end
			@win
		end	
end

