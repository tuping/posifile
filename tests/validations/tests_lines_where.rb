require 'posifile'
require 'test/unit'
require 'test_helpers'

class WithLinesWhere < Posifile
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

class WithLinesWhereWithGap < Posifile
	# this class is used to test if order in the declariations matter
	lines_where(0..2, "001") do
		set_specification("brand"=>3..12, "color"=>15..22)
	end	

	lines_where 0..2, "002" do
		set_specification( "color1"=>13..22,"brand1"=>3..12)
		set_attr_name :brand1
	end

	lines_where(0..2, "003") do
		set_specification("brand2"=>3..12, "color2"=>13..22)
  end	
end

class WithLinesWhereWithOverlap < Posifile
	# this class is used to test if order in the declariations matter
	lines_where(0..2, "001") do
		set_specification("brand"=>3..12, "color"=>13..22)
	end	

	lines_where 0..2, "002" do
		set_specification( "color1"=>13..22,"brand1"=>3..12)
		set_attr_name :brand1
	end

	lines_where(0..2, "003") do
		set_specification("brand2"=>3..12, "color2"=>10..22)
  end	
end

class TestLinesWhere < Test::Unit::TestCase
	def test_valid_true
		assert WithLinesWhere.valid_specification?
	end

	def test_with_gap
		assert !WithLinesWhereWithGap.valid_specification?
	end

	def test_with_overlap
		assert !WithLinesWhereWithGap.valid_specification?
	end
end
