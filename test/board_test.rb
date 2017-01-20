require_relative 'test_helper.rb'
require './lib/board.rb'

class BoardTest < MiniTest::Test
attr_reader :board

	def setup
		@board = Board.new
	end

	def test_is_the_player_board_an_array
		assert_equal Array, board.player_board.class
	end

	def test_does_board_array_have_nested_array_elements
		assert 4, board.player_board.count
		assert Array, board.player_board[0].class
	end

	def test_does_each_nested_array_have_four_elements
		assert 4, board.player_board[0].count
		assert 4, board.player_board[1].count
		assert 4, board.player_board[2].count
		assert 4, board.player_board[3].count
	end

	def test_computer_board_and_player_board_same_at_initialization
		assert true, board.player_board.eql?(board.computer_board)
	end

	def test_display_board_and_others_are_different
		refute board.player_board.eql?(board.display_board)
		refute board.computer_board.eql?(board.display_board)
	end
	
end