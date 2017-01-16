require_relative 'board.rb'
require_relative 'ship.rb'
require_relative 'messages.rb'
require_relative 'macaction.rb'
require_relative 'timer.rb'
require_relative 'translator.rb'
require_relative 'player.rb'
require_relative 'cli.rb'

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
								:shot_counter
							

	def initialize
    @board = Board.new
		@player = Player.new
		@ship = Ship.new
		@mac = MacAction.new
		@timer = Timer.new
		@mac_board = board.computer_board
		@player_board = board.player_board
		@shot_counter = 0
	end

	def hud
		board.pretty
	end

	def startup
		puts Message.start_game
		input = gets.chomp
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
		case
			when CLI.quit?(input)
				abort
			when CLI.play?(input)
				computer_setup
		end
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
		player.place_ship_1(player_board, input)
	end

	def place_ship_2
		puts Message.place_ship_2
		input = gets.chomp.upcase
		player.place_ship_2(player_board, input)
	end

	def player_setup
		place_ship_1
		place_ship_2
		turn
	end

	def mac_turn
		mac.shoot(player_board)
		puts Message.shot_prompt
	end

	def player_turn
		input = gets.chomp.upcase
		player.shoot(mac_board, input)
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
		Translator.translate(input)
		if player.hit
			hud[Translator.pos_1][Translator.pos_2] = 'H'
		else
			hud[Translator.pos_1][Translator.pos_2] = 'M'
		end
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
    