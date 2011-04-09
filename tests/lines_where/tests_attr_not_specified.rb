require 'posifile'
require 'test/unit'
require 'test_helpers'

class NoSpecModel < Posifile
	lines_where 0..2, "001" do
	end
end

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
	# one specification, for a multi-line file, but doesn't have the set_attr_name. It should behave like in the one-line file.
	lines_where(0..2, "001") do
		set_specification( "color"=>13..22,"brand"=>3..12)
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


class MultiLinesWithTwoSpecsWithOneSetAttrNameMissing4 < Posifile
	# this class is used to test if order in the declariations matter
	lines_where(0..2, "001") do
		set_specification("brand"=>3..12, "color"=>13..22)
	end	

	lines_where 0..2, "002" do
		set_specification( "color1"=>13..22,"brand1"=>3..12)
		set_attr_name :brand1
	end

	lines_where(0..2, "003") do
		set_specification("brand2"=>3..12, "color2"=>13..22)
  end	
end

class TestAttrNotSpecified < Test::Unit::TestCase
	include TestHelpers

	def setup
		create_multi_lines_sample
	end

	def test_no_spec_model
		assert_raise(FieldsNotSpecified) do
			no_spec = NoSpecModel.new("samples/sample.txt")
		end
	end

	def test_attr_name_not_specified
			car = MultiLinesWithTwoSpecsWithOneSetAttrNameMissing1.new("samples/multi_line_sample.txt")
			assert_equal String, car.color.class
	end

	def test_attr_name_not_specified2
			car = MultiLinesWithTwoSpecsWithOneSetAttrNameMissing2.new("samples/multi_line_sample.txt")
			assert_equal String, car.brand.class
	end

	def test_attr_name_not_specified3
			car = MultiLinesWithTwoSpecsWithOneSetAttrNameMissing3.new("samples/multi_line_sample.txt")
			assert_equal Hash, car.harley.class
			assert_equal String, car.color.class
	end

	def test_attr_name_not_specified4
			car = MultiLinesWithTwoSpecsWithOneSetAttrNameMissing4.new("samples/multi_line_sample.txt")
			assert_equal String, car.color.class
			assert_equal Hash, car.harley.class
			assert_equal String, car.color2.class
	end

end
