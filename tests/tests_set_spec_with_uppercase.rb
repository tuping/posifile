require 'posifile'
require 'test/unit'
require 'test_helpers'

class SpecWithUppercase < Posifile
end

class TestPosifile < Test::Unit::TestCase

	include TestHelpers

	def test_set_spec_with_uppercase
		assert_raise(UppercaseFieldsError) do
			SpecWithUppercase.set_specification("Name"=>0..10, "CITY"=>11..31,"country"=>32..42)
		end
	end

end
