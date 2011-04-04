require 'posifile'
require 'test/unit'
require 'test_helpers'

class OneLineWithOneSpec < Posifile

	# just one specification, for a one-line file
	lines_where 0..2, "001" do
		set_specification("color"=>3..12)
	end
end

class TestLinesWhere < Test::Unit::TestCase
	include TestHelpers
	def setup
		create_one_line_sample
	end

	def test_lines_where_one_line_one_spec
		car = OneLineWithOneSpec.new("samples/one_line_sample.txt")
		assert_equal "yellow", car.color
	end

end
