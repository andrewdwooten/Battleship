module Message

  def self.start_game
		"Welcome to BATTLESHIP
        
        
    Would you like to (p)play, read the (i)nstructions, or (q)uit?"
	end

	def self.instructions
		"Place your ships using the co-ordinates to indicate the first and last position of the ship('A1 A3' for example). After this the game commences.  You and the computer will alternate taking one shot each, guessing where the other has placed their ships, until one opponents ships are all destroyed.When prompted, enter your shot with the coordinate('A1' for example). Have fun!  (p)lay or (q)uit?"
	end

	def self.computer_finished_placement
	   "I have laid out my ships on the grid. You now need to layout your two ships. The first is two units long and the second is three units long. The grid has A1 at the top left and D4 at the bottom right."
	end

	def self.place_ship_1
		"Enter the squares for the Destroyer(2-units):"
	end

	def self.place_ship_2
		"Enter the squares for the Submarine(3-units):"
	end

	def self.invalid_placement
		"Enter valid co-ordinates for ship placement."
	end

	def self.computer_hit
		"I hit one of your ships!!"
	end

	def self.computer_miss
		"I missed!!"
	end

	def self.shot_prompt
		"Enter your coordinates to fire. (Ex. 'A1')"
	end

	def self.hit
		"HIT!!!"
	end

	def self.miss
		"miss...aim...better...?"
	end

	def self.invalid_shot
		"Shoot at a space on the board, please."
	end

	def self.lose
		"Sorry person. You lost!  Foolish human..."
	end

	def self.win
		"YOU'RE A WINNER!!  DOESN'T THAT FEEL GREAT?!"
	end
end 