require_relative 'board.rb'
require_relative 'ship.rb'
require_relative 'messages.rb'
require_relative 'macaction.rb'
require_relative 'timer.rb'
require_relative 'translator.rb'
require_relative 'player.rb'
require_relative 'cli.rb'
require 'pry'

class Game
include Message
include CLI
include Translator

attr_reader 	:board,
							:player,
							:ship,
							:mac,
							:timer,
							:mac_board,
							:player_board,
							:shot_counter,
							:hud
							

	def initialize
    @board = Board.new
		@player = Player.new
		@ship = Ship.new
		@mac = MacAction.new
		@timer = Timer.new
		@mac_board = board.computer_board
		@player_board = board.player_board
		@shot_counter = 0
		@hud = board.pretty
	end

	def startup
		puts Message.start_game
		input = gets.chomp
		decision_tree(input)
	end

	def decision_tree(input)
			case
			when CLI.instructions?(input)
				game_instructions
			when CLI.play?(input)
				computer_setup
			when CLI.quit?(input)
				abort
			when CLI.invalid?(input)
				puts Message.invalid_command; startup
			end
	end

	def game_instructions
		puts Message.instructions
		input = gets.chomp.downcase
		decision_tree(input)
	end
				
	def computer_setup
		mac.place_ships(mac_board,ship.destroyer)
		mac.place_ships(mac_board,ship.submarine)
		puts Message.computer_finished_placement
		player_setup
	end

	def place_ship_1
		puts Message.place_ship_1
		input = gets.chomp.upcase
		check_ship_1(input)
	end

	def check_ship_1(input)
		player.place_ship_1(player_board, input) == 'd' ?
		 player.place_ship_1(player_board, input) : ((puts Message.invalid_placement);place_ship_1)
	end

	def place_ship_2
		puts Message.place_ship_2
		input = gets.chomp.upcase
		check_ship_2(input)
	end

	def check_ship_2(input)
		player.place_ship_2(player_board, input) == 's' ?
			player.place_ship_2(player_board, input) : ((puts Message.invalid_placement); place_ship_2)
	end

	def player_setup
		place_ship_1
		place_ship_2
		turn
	end

	def mac_turn
		mac.shoot(player_board)
		mac_turn_feedback
	end

	def mac_turn_feedback
	 mac.check_hit?(player_board) ? (puts Message.computer_hit) :
	 	(puts Message.computer_miss)
	 puts Message.shot_prompt
	end

	def player_turn
		input = gets.chomp.upcase
		player.shoot(mac_board, input)
		player_turn_feedback(input)
	end

	def player_turn_feedback(input)
		player.hit ? (puts Message.hit) : (puts Message.miss)
		update_HUD(input)
	end

	def turn
		timer.start
		until player.win?(mac_board) || mac.win?(player_board)
			puts board.pretty
			mac_turn
			player_turn
			@shot_counter += 1
		 end
		 timer.stop
		 end_sequence
	end

	def update_HUD(input)
		translate(input)
		player.hit ? hud[pos_1][pos_2] = 'H' : hud[pos_1][pos_2] = 'M'
	end

	def end_sequence
		mac.win?(player_board) ? (puts Message.lose) : (puts Message.win)
		shot_report
		time_lapse
	end

	def shot_report
		puts "You fired #{shot_counter} shots!"
	end

	def time_lapse
		puts "You played this long: #{@timer.elapsed} seconds"
	end
end 

a = Game.new
a.startup
    