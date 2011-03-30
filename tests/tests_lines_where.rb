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
		car = MultiLinesWithTwoSpecs.new("samples/multi_line_sample.txt")
		assert_equal car.fusca.class == Hash
		assert_equal car.uno.class == Hash
		assert_equal "fusca", car.fusca["name"]
		assert_equal "uno", car.uno["name"]
		assert_equal "yamaha", car.yamaha["name"]
		assert_equal "blue", car.yamaha["color"]
	end

	def test_lines_where_two_lines_one_spec_yellow
		car = MultiLinesWithOneSpec.new("samples/multi_line_sample.txt")
		assert_equal "fusca", car.carros
	end


#	def test_lines_where_undefined
#		assert_raise(UndefinedSpecification) { car = Car2.new("samples/car2_sample.txt") }
#	end
end

