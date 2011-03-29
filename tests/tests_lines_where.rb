require 'posifile'
require 'test/unit'
require 'test_helpers'

class Car < Posifile
	
	set_specification("color"=>3..9)

	lines_where 1..3, 001 do

	end

#	lines_where 1..3, 002 do
#		color = "002color"
#	end
end

class TestLinesWhere < Test::Unit::TestCase
include TestHelpers
	def setup
		create_car_sample
	end

	def test_lines_where
		car = Car.new("samples/car_sample.txt")
		assert_equal "001color", Car.var
	end
end
