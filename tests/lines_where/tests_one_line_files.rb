require 'posifile'
require 'test/unit'
require 'test_helpers'

class OneLineWithOneSpec < Posifile

	# just one specification, for a one-line file
	lines_where 0..2, "001" do
		set_specification("color"=>3..12)
	end
end

class OneLineWithOneSpecWithUppercase < Posifile
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

	def test_lines_where_one_line_one_spec_with_uppercase
		assert_raise(UppercaseFieldsError) do 
			OneLineWithOneSpecWithUppercase.lines_where 0..2, "001" do
				OneLineWithOneSpecWithUppercase.set_specification("Color"=>3..12)
			end
		end
	end

end
