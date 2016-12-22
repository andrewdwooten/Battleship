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
							  :HUD,
								:shot_counter
							

	def initialize
    @board = Board.new
		@player = Player.new
		@ship = Ship.new
		@mac = MacAction.new
		@timer = Timer.new
		@mac_board = board.computer_board
		@player_board = board.player_board
		@HUD = board.pretty
		@shot_counter = 0
	end

	def startup
		puts Message.start_game
			@input = gets.chomp
			case
				when CLI.instructions?(@input)
					puts Message.instructions
						@input = gets.chomp
							case
							when CLI.quit?(@input)
								abort
							when CLI.play?(@input)
								self.computer_setup
							end
				when CLI.play?(@input)
					self.computer_setup
				when CLI.quit?(@input)
					abort
				end		
	end

	def computer_setup
		mac.place_ships(mac_board,ship.destroyer)
		mac.place_ships(mac_board,ship.submarine)
		puts Message.computer_finished_placement
		self.setup
	end


	def setup
		puts Message.place_ship_1
		pos_1 = gets.chomp
		player.place_ship_1(player_board, pos_1)
		puts Message.place_ship_2
		pos_2 = gets.chomp
		player.place_ship_2(player_board, pos_2)
		self.turn
	end

	def turn
		timer.start
		until player.win?(mac_board) == true || mac.win?(player_board) == true
			puts board.pretty
			mac.shoot(player_board)
			puts Message.shot_prompt
			@input = gets.chomp
			player.shoot(mac_board, @input)
			self.update_HUD(@input)
			@shot_counter += 1
		 end
		 timer.stop
		 self.end_sequence
	end

	def update_HUD(input)
		Translator.translate(input)
		if player.hit
			@HUD[Translator.pos_1][Translator.pos_2] = 'H'
		else
			@HUD[Translator.pos_1][Translator.pos_2] = 'M'
		end
	end

	def end_sequence
		if mac.win?(player_board)
			puts Message.lose
		else
			puts Message.win
		end
		puts "You played this long: #{@timer.elapsed} seconds"
		puts "You fired #{@shot_counter} shots!"
	end
end 
    