require 'posifile'
require 'test/unit'
require 'test_helpers'

class UppercasedSpec < Posifile 
end

class TestsCheckForUppercase < Test::Unit::TestCase

	include TestHelpers

	def setup
	end

	def tests_check_for_uppercase_false
		assert UppercasedSpec.check_for_uppercase({"Name"=>1..10, "CITY"=>11..20, "country"=>21..32})
	end

	def tests_check_for_uppercase_true
		assert !UppercasedSpec.check_for_uppercase({"name"=>1..10, "city"=>11..20, "country"=>21..32})
	end

end
