require_relative 'test_helper.rb'
require './lib/translator.rb'

class TranslatorTest < MiniTest::Test
	attr_reader :Translator

	def test_translator_outputs_array
		output = Translator.translate("A4")
		assert_equal Array, output.class
	end

	def test_translator_output_gives_numeric_coordinates
		output = Translator.translate("A4")
		assert_equal 2, output.count
		assert output.include?(0)
		assert output.include?(3)
		assert_equal [0,3], output
	end

	def test_pos_1_through_pos_4_are_fix_num
		output = Translator.translate("A4 D1")
		assert Fixnum, Translator.pos_1.class
		assert Fixnum, Translator.pos_2.class
		assert Fixnum, Translator.pos_3.class
		assert Fixnum, Translator.pos_4.class
	end

	def test_out_of_bounds_output_is_nil
		output = Translator.translate("A5")
		assert 0, Translator.pos_1
		assert_equal nil, Translator.pos_2
	end
end