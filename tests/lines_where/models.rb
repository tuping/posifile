class MultiLinesWithTwoSpecs1 < Posifile

	# two specifications, for a two-line file, work fine
	lines_where 0..2, "001" do
		set_specification( "color"=>13..22,"brand"=>3..12)
		set_attr_name :color
	end

	lines_where 0..2, "002" do
		set_specification("motos"=>3..12)
	end
end

class MultiLinesWithTwoSpecs2 < Posifile

	# two specifications, for a two-line file, work fine
	lines_where 0..2, "001" do
		set_specification( "color"=>13..22,"brand"=>3..12)
		set_attr_name :brand
	end

	lines_where 0..2, "002" do
		set_specification("motos"=>3..12)
	end
end

class MultiLinesWithOneSpec < Posifile

	# just one specification, for a two-line file, should raise exception on initialize
	# but it doesn't do tthat yet, and dont have tests for this, but seems to work.
	lines_where 0..2, "001" do
		set_specification("brand"=>3..9)
	end
end
