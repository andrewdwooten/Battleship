require_relative 'messages.rb'

module CLI

	def self.play?(input)
		input.downcase == 'p'
	end

	def self.quit?(input)
		input.downcase == 'q'
	end

	def self.instructions?(input)
		input.downcase == 'i'
	end

	def self.invalid?(input)
		input != 'p' && input != 'q'
	end
		
end

	
