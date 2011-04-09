require 'posifile'
require 'test/unit'
require 'test_helpers'

class MultiLinesWithUppercaseFields < Posifile

	# two specifications, for a multi-line file
	lines_where 0..2, "001" do
		set_specification( "color"=>13..22,"brand"=>3..12)
		set_attr_name :brand
	end
end

class TestUppercaseFields < Test::Unit::TestCase

	include TestHelpers

	def setup
		create_multi_lines_sample
		create_multi_lines_sample_with_uppercase
	end

	def test_lines_where_with_uppercase_fields
		car = MultiLinesWithUppercaseFields.new("samples/multi_line_sample_with_uppercase.txt")
		
		assert_equal "bege", car.fusca['color']
		assert_equal "Yellow", car.uno['color']
	end

end

