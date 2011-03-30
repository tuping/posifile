require 'posifile'

class Client < Posifile 
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>32..42
										)
end

#Used in validations tests -------------------

class WithGap <Posifile
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>36..52
										)
end

class WithOverlap < Posifile
	set_specification("name"=>0..8, "address" => 8..20, "job" => 16..30)
end

class BothGapAndOverlap < Posifile
	set_specification("name"=>0..8, "address" => 10..20, "job" => 16..30)
end
#--------------------------------------------


#used in lines_where tests ------------------

class OneLineWithOneSpec < Posifile

	# just one specification, for a one-line file
	lines_where 0..2, "001" do
		set_specification("color"=>3..12)
	end
end

class MultiLinesWithTwoSpecs < Posifile

	# two specifications, for a two-line file, work fine
	lines_where 0..2, "001" do
		set_specification("carros"=>3..12, "color"=>13..22)
		set_attr_name :carros
	end

	lines_where 0..2, "002" do
		set_specification("motos"=>3..12)
	end
end

class MultiLinesWithOneSpec < Posifile

	# just one specification, for a two-line file, should raise exception on initialize
	# but it doenst yet, and dont have tests for this, but seems to work.
	lines_where 0..2, "001" do
		set_specification("carros"=>3..9)
	end
end
