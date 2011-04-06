require 'posifile'
require 'test/unit'
require 'test_helpers'

class TestsChangeName < Test::Unit::TestCase

	include TestHelpers

	def test_um
		c = Client.new("samples/sample.txt")
		assert_equal "parangaricotirimirru_aro",c.change_name("parangaricotirIMi*rr\&u a-r.o")
	end

end
