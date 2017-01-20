require_relative 'test_helper.rb'
require './lib/macaction.rb'
require './lib/board.rb'
require './lib/ship.rb'
require './lib/player.rb'

class MacActionTest < MiniTest::Test
attr_reader :board, :mac, :ship, :mac_board, :me
include Message

def setup
	@board = Board.new
	@mac = MacAction.new
	@ship = Ship.new
  @mac_board = board.computer_board
  @me = Player.new
end

	def test_place_ships_changes_computer_board
    mac.place_ships(mac_board, ship.destroyer)
    refute board.player_board.eql?(mac_board)
  end

  def test_place_destroyer_adds_two_ds_to_computer_board
    mac.place_ships(mac_board, ship.destroyer)
    assert 16, mac_board.count
		assert 16, mac_board.flatten.bsearch{|e| e.to_i == 0}
    assert 2, mac_board.flatten.bsearch {|e| e == 'd'}
	end

  def test_placing_destroyer_adds_three_ss_to_board
    mac.place_ships(mac_board, ship.submarine)
		assert 3, mac_board.flatten.bsearch {|e| e == 's'}
	end

	def test_two_ships_do_not_intersect_when_added_to_board
    mac.place_ships(mac_board, ship.submarine)
		mac.place_ships(mac_board, ship.destroyer)
		assert 2, mac_board.flatten.bsearch {|e| e == 'd'}
		assert 3, mac_board.flatten.bsearch {|e| e == 's'}
	end

  def test_computer_can_shoot_and_will_output_miss_message
    mac.place_ships(mac_board, ship.submarine)
    assert Message.computer_miss, mac.shoot(mac_board)
  end

  def test_computer_can_win
    assert mac.win?(mac_board)
  end

  def test_computer_can_also_not_win
    mac.place_ships(mac_board, ship.submarine)
    mac.place_ships(mac_board, ship.destroyer)
    refute mac.win?(mac_board)
  end

  def test_choose_spot_alters_a_and_b_values
    a = mac.a
    b = mac.b
    mac.choose_spot
    refute mac.a == a
    refute mac.b == b
  end
  
end
