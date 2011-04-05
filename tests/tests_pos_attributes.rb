require 'posifile'
require 'test/unit'
require 'test_helpers'

class Client < Posifile 
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>32..42
										)
end

class MultiLinesWithTwoSpecs3 < Posifile

	# two specifications, for a multi-line file
	lines_where 0..2, "001" do
		set_specification( "color"=>13..22,"brand"=>3..12)
		set_attr_name :brand
	end
end

class TestPosAttributes < Test::Unit::TestCase
# Here are general tests

	include TestHelpers

	def test_pos_attributes_one_line
		c = Client.new("samples/sample.txt")
		assert c.pos_attributes.include? "city"
		assert c.pos_attributes.include? "name"
		assert c.pos_attributes.include? "country"
		assert_equal 3, c.pos_attributes.length
	end

	def test_pos_attributes_multi_line
		p = MultiLinesWithTwoSpecs3.new("samples/multi_line_sample.txt")
		assert p.pos_attributes.include? "fusca"
		assert p.pos_attributes.include? "uno"
		assert p.pos_attributes.include? "vectra"
		assert_equal 3, p.pos_attributes.length
	end

end
