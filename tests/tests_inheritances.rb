require 'posifile'
require 'test/unit'
require 'test_helpers'
require 'client'

class MyClass < Client
end

class TestInheritance < Test::Unit::TestCase
	# Here are general tests

	include TestHelpers

	def test_one
		#car = MyClass.new("samples/sample.txt")
		assert true
	end
end
