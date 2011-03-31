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

	def test_lines_where_two_lines_two_specs_1
		car = MultiLinesWithTwoSpecs1.new("samples/multi_line_sample.txt")

		assert_equal "vectra", car.white['carros']
		assert_equal "uno", car.yellow['carros']
		assert_equal "white", car.white['color']

	end

	def test_lines_where_two_lines_two_specs_2
		car = MultiLinesWithTwoSpecs2.new("samples/multi_line_sample.txt")

		assert_equal Hash, car.fusca.class
		assert_equal "BEGE",car.fusca['color']
	end

#	def test_lines_where_two_lines_one_spec_yellow
#		car = MultiLinesWithOneSpec.new("samples/multi_line_sample.txt")
#		assert_equal "fusca", car.fusca["name"]
#	end


#	def test_lines_where_undefined
#		assert_raise(UndefinedSpecification) { car = Car2.new("samples/car2_sample.txt") }
#	end
end

