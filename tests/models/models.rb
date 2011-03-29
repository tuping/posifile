require 'posifile'

class Client < Posifile 
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>32..42
										)
end

class WithGap <Posifile
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>36..52
										)
end

class WithOverlap < Posifile
	set_specification("name"=>0..8, "address" => 8..20, "job" => 16..30)
end
