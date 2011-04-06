require 'posifile'
require 'test/unit'
require 'test_helpers'

class MultiLinesWithTwoSpecsWithOneSetAttrNameMissing1 < Posifile
	# two specifications, for a multi-line file, but one them doesn't have the set_attr_name. It should behave like in the one-line file.
	lines_where 0..2, "001" do
		set_specification( "color"=>13..22,"brand"=>3..12)
		set_attr_name :brand
	end

	lines_where 0..2, "002" do
		set_specification("brand"=>3..12, "color"=>13..22)
	end
end

class MultiLinesWithTwoSpecsWithOneSetAttrNameMissing2 < Posifile
	# one specifications, for a multi-line file, but doesn't have the set_attr_name. It should behave like in the one-line file.
	lines_where(0..2, "001") do
		set_specification( "color"=>13..22,"brand"=>3..12)
	end
end

class MultiLinesWithOneSpec < Posifile

	# just one specification, for a two-line file, should raise exception on initialize
	# but it doesn't do that yet, and dont have tests for this, but seems to work.
	lines_where 0..2, "001" do
		set_specification("brand"=>3..12)
		set_attr_name :brand
	end
end

class MultiLinesWithUppercaseFields < Posifile

	# two specifications, for a multi-line file
	lines_where 0..2, "001" do
		set_specification( "color"=>13..22,"brand"=>3..12)
		set_attr_name :brand
	end
end



class NoSpecModel < Posifile
	lines_where 0..2, "001" do
	end
end



class MultiLinesWithTwoSpecsWithOneSetAttrNameMissing3 < Posifile
	# this is excatly the same as MultiLinesWithTwoSpecsWithOneSetAttrNameMissing1 but in different order. And with different attr's
	lines_where(0..2, "001") do
		set_specification("brand"=>3..12, "color"=>13..22)
	end	

	lines_where 0..2, "002" do
		set_specification( "color1"=>13..22,"brand1"=>3..12)
		set_attr_name :brand1
	end
end


class TestLinesWhere < Test::Unit::TestCase

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

	def test_lines_where_two_lines_one_spec_yellow
		car = MultiLinesWithOneSpec.new("samples/multi_line_sample.txt")
		assert_equal "fusca", car.fusca["brand"]
	end

	def test_attr_name_not_specified
			car = MultiLinesWithTwoSpecsWithOneSetAttrNameMissing1.new("samples/multi_line_sample.txt")
			assert_equal String, car.color.class
	end

	def test_attr_name_not_specified2
			car = MultiLinesWithTwoSpecsWithOneSetAttrNameMissing2.new("samples/multi_line_sample.txt")
			assert_equal String, car.brand.class
	end

	def test_no_spec_model
		assert_raise(FieldsNotSpecified) do
			no_spec = NoSpecModel.new("samples/sample.txt")
		end
	end

	def test_attr_name_not_specified3
			car = MultiLinesWithTwoSpecsWithOneSetAttrNameMissing3.new("samples/multi_line_sample.txt")
			assert_equal String, car.color.class
	end

end

