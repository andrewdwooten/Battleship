module Message

  def self.start_game
		"Welcome to BATTLESHIP
        
        
    Would you like to (p)play, read the (i)nstructions, or (q)uit?\n \n"
	end

	def self.instructions
		"Place your ships using the co-ordinates to indicate the first\n and last position of the ship('A1 A3' for example). After this\nthe game commences.  You and the computer will alternate taking\none shot each, guessing where the other has placed their ships,\nuntil one opponents ships are all destroyed.When prompted,\n enter your shot with the coordinate('A1' for example). Have fun!\n(p)lay or (q)uit?\n \n"
	end

	def self.computer_finished_placement
	   "I have laid out my ships on the grid. \n You now need to layout your two ships. \nThe first is two units long and the \nsecond is three units long. The grid \nhas A1 at the top left and D4 at the bottom right.\n\n"
	end

	def self.invalid_command
		"Enter a valid command human!\n \n"
	end

	def self.place_ship_1
		"Enter the squares for the Destroyer(2-units):\n \n"
	end

	def self.place_ship_2
		"Enter the squares for the Submarine(3-units):\n \n"
	end

	def self.invalid_placement
		"Enter valid co-ordinates for ship placement.\n \n"
	end

	def self.computer_hit
		"I hit one of your ships!!\n \n"
	end

	def self.computer_miss
		"I missed!!\n \n"
	end

	def self.shot_prompt
		"Enter your coordinates to fire. (Ex. 'A1')\n \n"
	end

	def self.hit
		"HIT!!!\n \n"
	end

	def self.miss
		"miss...aim...better...?\n \n"
	end

	def self.invalid_shot
		"Shoot at a space on the board, please.\n \n"
	end

	def self.lose
		"Sorry person. You lost!  Foolish human...\n \n"
	end

	def self.win
		"YOU'RE A WINNER!!  DOESN'T THAT FEEL GREAT?!\n \n"
	end
end 