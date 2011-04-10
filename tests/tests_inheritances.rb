require 'posifile'
require 'test/unit'
require 'test_helpers'
require 'client'

class MyClass < Client
end

class OtherClass < MyClass
end

class TestInheritance < Test::Unit::TestCase
	# Here we test how deep in subclasses the library is gonna work (beacase there are self and self.class references in the code)

	include TestHelpers

	def test_inheritance_one
		car = MyClass.new("samples/sample.txt")
		assert_equal "jose", car.name
	end

	def test_inheritance_one
		car = OtherClass.new("samples/sample.txt")
		assert_equal "jose", car.name
	end
	
end
