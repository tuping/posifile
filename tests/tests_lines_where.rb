require 'posifile'
require 'test/unit'
require 'test_helpers'
require 'models/models'

class TestLinesWhere < Test::Unit::TestCase
	include TestHelpers
	def setup
		create_one_line_sample
		create_two_lines_sample
	end
	

	def test_lines_where_one_line_one_spec
		car = OneLineWithOneSpec.new("samples/one_line_sample.txt")
		assert_equal "yellow", car.color
	end

	def test_lines_where_two_lines_two_specs
		car = TwoLinesWithTwoSpecs.new("samples/two_lines_sample.txt")
		assert_equal "yellow", car.color1
		assert_equal "blue", car.color2
	end

	def test_lines_where_two_lines_one_spec_yellow
		car = TwoLinesWithOneSpec.new("samples/two_lines_sample.txt")
		assert_equal "yellow", car.color1
	end


#	def test_lines_where_undefined
#		assert_raise(UndefinedSpecification) { car = Car2.new("samples/car2_sample.txt") }
#	end
end

