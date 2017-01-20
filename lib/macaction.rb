require_relative 'board.rb'
require_relative 'messages.rb'

class MacAction
include Message
	attr_accessor :win, :a, :b
	
  def initialize
  end

	def choose_spot
		@a = rand(4)
		@b = rand(4)
	end

	def place_ships(board, ship)
		choose_spot
		if board[a][b] == '0'
			board[a][b] = ship[0] 
			case 
				when go_right?(board)
						 go_right(board, ship)
				when go_left?(board)
						 go_left(board, ship)
				when go_up?(board)
						 go_up(board, ship)
				when go_down?(board)
						 go_down(board,ship)
				else 
						board[a][b] ='0'
						place_ships(board,ship)
				end
		else
		end
	end

	def go_right?(board)
		board[a][b + 1] == '0' && board[a][b + 2] == '0'
	end

	def go_right(board, ship)
		board[a][b + 1] = ship[1]
		board[a][b + 2] = ship[2] if ship[2] != nil 
	end

	def go_left?(board)
		board[a][b - 1] == '0' && board[a][b - 2] == '0'
	end

	def go_left(board, ship)
		board[a][b - 1] = ship[1]
		board[a][b - 2] = ship[2] if ship[2] != nil 
	end

	def go_up?(board)
		board[a + 1][b] == '0' && board[a + 2][b] == '0'
	end

	def go_up(board, ship)
		board[a + 1][b] = ship[1]
		board[a + 2][b] = ship[2] if ship[2] != nil 
	end

	def go_down?(board)
		board[a - 1][b] == '0' && board[a - 2][b] == '0'
	end

	def go_down(board, ship)
		board[a - 1][b] = ship[1]
		board[a - 2][b] = ship[2] if board[2] != nil 
	end

	def shoot(board)
		choose_spot
		bang(board) if check_hit?(board)
	end

	def check_hit?(board)
		board[a][b] != '0'
	end

	def bang(board)
		board[a][b] = '0'
	end

	def win?(board)
		check_board?(board) ? @win = false : @win = true
	end
			
	def check_board?(board)
		board.flatten.include?("d") || board.flatten.include?("s")
	end
end

