class Timer
  require 'time'
  attr_reader :elapsed, :end_time
	def initialize
	end

	def start
		@start_time = Time.now
	end

	def stop
		@end_time = Time.now
	end

	def elapsed
		@elapsed_time = @end_time - @start_time
	end
end

