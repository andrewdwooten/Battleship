require_relative 'test_helper.rb'
require './lib/player.rb'


class PlayerTest < MiniTest::Test
	attr_reader :me, :board, :player_board

def setup
  @me = Player.new
	@board = Board.new
	@player_board = board.player_board
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

		def test_player_cannot_enter_invalid_coordinates
			assert String, [me.place_ship_1(player_board,"asdf A5")].class
		end

		def test_player_cannot_enter_coordinates_that_are_too_far_apart
			assert String, me.place_ship_1(player_board, "A1 A4").class
			assert String, me.place_ship_2(player_board, "A1 D1").class
		end

		def test_player_cannot_place_ships_diagonally_on_board
			assert String, me.place_ship_1(player_board, "A1 A2")
			assert String, me.place_ship_2(player_board, "A1 C3")
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
end