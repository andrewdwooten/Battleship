require_relative 'test_helper.rb'
require './lib/player.rb'


class PlayerTest < MiniTest::Test
	attr_reader :me, :board, :player_board, :mac_board

def setup
  @me = Player.new
	@board = Board.new
	@player_board = board.player_board
	@mac_board = board.computer_board
end

    def test_player_can_place_destoyer
      me.place_ship_1(player_board,"A1 B1")
      refute player_board.eql?board.computer_board
			assert 2, player_board.bsearch {|e| e == 'd'}
    end

		def test_player_can_overlap_two_destoryers
			me.place_ship_1(player_board,"A1 B1")
			me.place_ship_1(player_board,"B1 B2")
			assert 4, player_board.bsearch {|e| e == 'd'}
		end

		def test_player_can_place_submarine
			me.place_ship_2(player_board,"A1 A3")
			refute player_board.eql?board.computer_board
			assert 3, player_board.bsearch {|e| e == 's'}
		end

		def test_two_submarines_can_overlap
			me.place_ship_2(player_board, "A1 A3")
			me.place_ship_2(player_board, "A3 C3")
			assert 6, player_board.bsearch {|e| e == 's'}
		end

		def test_player_can_place_a_submarine_and_a_destroyer
			me.place_ship_2(player_board,"A1 A2")
			me.place_ship_1(player_board,"B1 B3")
			assert 5, player_board.bsearch {|e| e != '0'}
			assert 3, player_board.bsearch {|e| e == 's'}
			assert 2, player_board.bsearch {|e| e == 'd'}
		end

		def test_player_can_place_ships_vertically
			me.place_ship_1(player_board, "A1 B1")
			me.place_ship_2(player_board, "A4, C4")
			assert 2, player_board.bsearch{|e| e == 'd'}
			assert 3, player_board.bsearch{|e| e == 's'}
		end

		def test_player_can_hit_ship_changing_map
			me.place_ship_1(board.computer_board, "A1 B1")
			assert me.shoot(board.computer_board, "A1")
			me.shoot(board.computer_board, "A1")
			refute board.computer_board.eql?(player_board)
			assert 1, board.computer_board.bsearch{|e| e == 's'}
		end

		def test_player_can_miss_with_ship_unchanged
			me.place_ship_1(board.computer_board, "A1 B1")
			refute me.shoot(board.computer_board, "D4")
			me.shoot(board.computer_board, "D4")
			assert 2, board.computer_board.bsearch{|e| e == 's'}
		end

		def test_player_knows_player_has_won
			mac_board = board.computer_board
			assert me.win?(mac_board)
		end

		def test_player_knows_player_has_not_won
			mac_board = board.computer_board
			me.place_ship_1(mac_board, "A1 B1")
			refute me.win?(mac_board)
		end

		def test_when_player_wins_a_string_is_returned
			mac_board = board.computer_board
			me.place_ship_1(mac_board, "A1 B1")
			assert String, me.win?(mac_board).class
		end

		def test_check_row_and_column_returns_appropriate_boolean
			assert me.check_row_and_column?(0,0,0,1)
			refute me.check_row_and_column?(4,2,2,3)
		end

		def test_check_destroyer_continuity_returns_appropriate_boolean
			assert me.check_destroyer_continuity?(0,0,0,1)
			refute me.check_destroyer_continuity?(2,3,4,1)
		end

		def test_check_destroyer_path_returns_appropriate_boolean
			me.place_ship_1(player_board, 'A1 A2')
			refute me.check_destroyer_path?(player_board,0,0,0,1)
			assert me.check_destroyer_path?(player_board,1,0,1,1)
		end

		def test_check_destroyer_placement_returns_appropriate_boolean
			me.place_ship_1(player_board, 'A1 A2')
			refute me.check_destroyer_placement?(player_board, 0,0,0,1)
			assert me.check_destroyer_placement?(player_board,1,0,1,1)
		end

		def test_check_submarine_continuity_returns_appropriate_boolean
			assert me.check_submarine_continuity?(0,0,0,2)
			refute me.check_submarine_continuity?(0,0,0,4)
		end

		def test_check_submarine_path_returns_appropriate_boolean
			me.place_ship_1(player_board, 'A1 A2')
			refute me.check_submarine_path?(player_board,0,0,0,2)
			assert me.check_submarine_path?(player_board,1,0,1,2)
		end

		def test_check_submarine_placement_returns_appropriate_boolean
			me.place_ship_1(player_board, 'A1 A2')
			refute me.check_submarine_placement?(player_board,0,0,0,2)
			refute me.check_submarine_placement?(player_board,0,1,1,4)
			refute me.check_submarine_placement?(player_board,0,3, 1,4)
			assert me.check_submarine_placement?(player_board,0,3,2,3)
		end

		def test_check_hit_returns_appropriate_boolean
			me.place_ship_1(player_board, 'A1 A2')
			assert me.check_hit?(player_board, 0,0)
			refute me.check_hit?(player_board, 3,2)
		end

		def test_bang_changes_board_and_value_of_hit
			refute me.hit
			me.place_ship_1(player_board, 'A1 A2')
			me.bang(player_board, 0,0)
			assert 0, player_board[0][0]
			assert 'd', player_board[0][1]
			assert me.hit
		end

		def test_miss_changes_value_of_hit
			refute me.hit
			me.place_ship_1(player_board, 'A1 A2')
			me.bang(player_board, 0,0)
			assert me.hit
			me.miss
			refute me.hit
		end

		def test_check_board_returns_appropriate_boolean
			me.place_ship_1(player_board, 'A1 A2')
			assert me.check_board?(player_board)
			refute me.check_board?(mac_board)
		end

		def test_win_method_changes_win_value
			me.place_ship_1(player_board, 'A1 A2')
			me.win?(player_board)
			refute me.win
			me.win?(mac_board)
			assert me.win
		end



end