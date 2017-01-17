require_relative 'test_helper.rb'
require './lib/messages.rb'

class MessageTest < MiniTest::Test

	def test_start_game_message
		welcome = Message.start_game
		refute welcome.empty?
		assert welcome.start_with?("Welcome")
		assert welcome.end_with?("(q)uit?\n \n")
	end

	def test_instructions_message
		instructions = Message.instructions
		refute instructions.empty?
		assert instructions.start_with?("Place")
		assert instructions.end_with?("(q)uit?\n \n")
	end

	def test_computer_finished_placement
		finished = Message.computer_finished_placement
		refute finished.empty?
		assert finished.start_with?("I have")
		assert finished.end_with?("bottom right.\n\n")
	end

	def test_place_ship_1_prompt
		place = Message.place_ship_1
		refute place.empty?
		assert place.start_with?("Enter")
		assert place.end_with?("2-units):\n \n")
	end

	def test_place_ship_2_prompt
		place = Message.place_ship_2
		refute place.empty?
		assert place.start_with?("Enter")
		assert place.end_with?("3-units):\n \n")
	end

	def test_hit_message
		hit = Message.hit
		refute hit.empty?
		assert hit.start_with?("HIT!!!")
		assert hit.end_with?("HIT!!!\n \n")
	end

	def test_miss_message
		miss = Message.miss
		refute miss.empty?
		assert miss.start_with?("miss...")
		assert miss.end_with?("ter...?\n \n")
	end

	def test_invalid_shot_message
		off_board = Message.invalid_shot
		refute off_board.empty?
		assert off_board.start_with?("Shoot at")
		assert off_board.end_with?("please.\n \n")
	end

	def test_lose_message
		lost = Message.lose
		refute lost.empty?
		assert lost.start_with?("Sorry")
		assert lost.end_with?("human...\n \n")
	end

	def test_win_message
		win = Message.win
		refute win.empty?
		assert win.start_with?("YOU'RE")
		assert win.end_with?("GREAT?!\n \n")
	end
end 
