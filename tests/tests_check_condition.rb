require 'posifile'
require 'test/unit'
require 'models/models'

class Person < Posifile
	lines_where(0..2, "001") do 
		set_specification("color"=>3..9)
	end
end

class TestLinesWhere < Test::Unit::TestCase
	
	def test_check_condition
		c = Person.new("samples/one_line_sample.txt")

		assert c.check_condition({0..2=>"001"}, "001opa")
	end

end
