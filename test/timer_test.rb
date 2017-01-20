require_relative 'test_helper.rb'
require './lib/timer.rb'

class TimerTest < MiniTest::Test

	def test_timer
		stopwatch = Timer.new
		stopwatch.start
		stopwatch.stop
		assert_equal stopwatch.end_time - stopwatch.start, stopwatch.elapsed
	end
	
end

