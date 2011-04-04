require 'posifile'
require 'test/unit'
require 'test_helpers'
require 'lines_where/models'

class TestLinesWhere < Test::Unit::TestCase
	include TestHelpers
	def setup
		create_one_line_sample
		create_two_lines_sample
	end

	def test_lines_where_two_lines_two_specs_1 
		#with :color as attr_name
		car = MultiLinesWithTwoSpecs1.new("samples/multi_line_sample.txt")

		assert_equal "vectra", car.white['brand']
		assert_equal "uno", car.yellow['brand']
		assert_equal "white", car.white['color']

	end

	def test_lines_where_two_lines_two_specs_2
		#with :brand as attr_name
		car = MultiLinesWithTwoSpecs2.new("samples/multi_line_sample.txt")

		assert_equal Hash, car.fusca.class
		assert_equal "bege",car.fusca['color']
	end

#	def test_lines_where_two_lines_one_spec_yellow
#		car = MultiLinesWithOneSpec.new("samples/multi_line_sample.txt")
#		assert_equal "fusca", car.fusca["name"]
#	end


#	def test_lines_where_undefined
#		assert_raise(UndefinedSpecification) { car = Car2.new("samples/car2_sample.txt") }
#	end
end
