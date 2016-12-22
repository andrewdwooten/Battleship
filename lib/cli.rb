require_relative 'messages.rb'

module CLI
	attr_accessor :input

	def input
		@input = gets.chomp
	end

	def self.play?(input)
		input == 'p'
	end

	def self.quit?(input)
		input == 'q'
	end

	def self.instructions?(input)
		input == 'i'
	end
end

	
