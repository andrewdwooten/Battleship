require_relative 'test_helper.rb'
require './lib/translator.rb'

class TranslatorTest < MiniTest::Test
	include Translator

	def test_translator_outputs_array
		output = translate("A4")
		assert_instance_of Array, output
	end

	def test_translator_output_gives_numeric_coordinates
		output = translate("A4")
		assert_equal 2, output.count
		assert output.include?(0)
		assert output.include?(3)
		assert_equal [0,3], output
	end

	def test_pos_1_through_pos_4_are_fix_num
		output = translate("A4 D1")
		assert_equal 0, pos_1
		assert_equal 3, pos_2
		assert_equal 3, pos_3
		assert_equal 0, pos_4
	end

	def test_out_of_bounds_output_is_nil
		output = translate("A5")
		assert 0, pos_1
		assert_equal nil, pos_2
	end
end 