require_relative 'test_helper.rb'
require './lib/ship.rb'

class ShipTest < MiniTest::Test
attr_reader :ship, :destroyer, :submarine

  def setup
    @ship = Ship.new
    @destroyer = ship.destroyer
    @submarine = ship.submarine
  end

  def test_destroyer_is_an_array
    assert_equal Array, ship.destroyer.class
  end

  def test_destroyer_array_has_two_identical_elements
    assert 2, destroyer.count
    assert destroyer[0].eql?(destroyer[1])
  end

  def test_each_destroyer_element_is_string_d
    assert 2, destroyer.bsearch {|e| e == 'd'}
  end

  def test_submarine_is_an_array
    assert_equal Array, submarine.class
  end

  def test_submarine_has_three_identical_elements
		assert_equal 3, submarine.count
		assert submarine[0].eql?(submarine[1])
		assert submarine[1].eql?(submarine[2])
	end

  def test_each_submarine_element_is_string_s
    assert 3, submarine.bsearch {|e| e == 's'}
  end
  
end

