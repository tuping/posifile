require 'posifile'
require 'test/unit'
require 'test_helpers'

class MultiLinesWithOneSpecAndAbsetAttrName < Posifile
	# two specifications, for a multi-line file, but one them doesn't have the set_attr_name. It should behave like in the one-line file.
	lines_where 0..2, "001" do
		set_specification( "color"=>13..22,"brand"=>3..12)
		set_attr_name :los_cabaleros_del_zodiaco
	end
end

class TestInvalidAttrName < Test::Unit::TestCase
	include TestHelpers
	def setup
	end

	def test_invalid_attr_name
		assert_raise(InvalidAttrName) do
		 		car = MultiLinesWithOneSpecAndAbsetAttrName.new("samples/multi_line_sample.txt")
		end
	end
end
