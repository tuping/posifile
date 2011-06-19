require 'posifile'
require 'test/unit'
require 'test_helpers'

class Person < Posifile
	lines_where(0..2, "001") do 
		set_specification("color"=>3..9)
	end
end

class TestCheckCondition < Test::Unit::TestCase

	include TestHelpers

	def setup
		create_one_line_sample
	end

	def test_check_condition_true
		c = Person.new("samples/one_line_sample.txt")

		assert c.check_condition({ 0..2 => "001" }, "001opa")
	end

	def test_check_condition_false
		c = Person.new("samples/one_line_sample.txt")

		assert !c.check_condition({ 0..2 => "001" }, "003opa")
	end

end
