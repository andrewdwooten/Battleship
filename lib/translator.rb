module Translator
	attr_reader :output, :translator, :pos_1, :pos_2, :pos_3, :pos_4

	def self.translate(input_string)
		output_num = [0,1,2,3,0,1,2,3]
		input = ['A','B','C','D', '1','2','3','4']
		@translator = input.zip(output_num).to_h
		output = []
		input_string.each_char do |char|
			output << @translator[char] end
		@output = output.compact
	end

	def self.pos_1
		@pos_1 = @output[0]
	end

	def self.pos_2
		@pos_2 = @output[1]
	end

	def self.pos_3
		@pos_3 = @output[2]
	end

	def self.pos_4
		@pos_4 = @output[3]
	end
end  



