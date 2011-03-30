require 'posifile'
require 'test/unit'
require 'test_helpers'

class OneLineWithOneSpec < Posifile

	# just one specification, for a one-line file
	lines_where 0..2, "001" do
		set_specification("color"=>3..9)
	end
end

class TwoLinesWithOneSpec < Posifile

	# just one specification, for a two-line file, should raise exception on initialize
	# this should raise exception, but it doenst yet, and dont have tests for this.
	lines_where 0..2, "002" do
		set_specification("color1"=>3..9)
	end
end

class TwoLinesWithTwoSpecs < Posifile

	# two specifications, for a two-line file, work fine
	lines_where 0..2, "001" do
		set_specification("color1"=>3..9)
	end

	lines_where 0..2, "002" do
		set_specification("color2"=>3..9)
	end
end

class TestLinesWhere < Test::Unit::TestCase
	include TestHelpers
	def setup
		create_one_line_sample
		create_two_lines_sample
	end
	

	def test_lines_where_only_one_line
		car = OneLineWithOneSpec.new("samples/one_line_sample.txt")
		assert_equal "yellow", car.color
	end

#	def test_lines_where_undefined
#		assert_raise(UndefinedSpecification) { car = Car2.new("samples/car2_sample.txt") }
#	end

	def test_lines_where
		car = TwoLinesWithTwoSpecs.new("samples/two_lines_sample.txt")
		assert_equal "yellow", car.color1
		assert_equal "blue", car.color2
	end
end

