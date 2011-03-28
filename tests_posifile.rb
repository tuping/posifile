require 'posifile'
require 'test/unit'
require 'test_helpers'

class Client < Posifile 
	set_data_file "sample.txt"
	set_specification({"name"=>0..10, 
											"city"=>11..31,
											"country"=>32..42
										})
end

class TestPosifile < Test::Unit::TestCase
	include TestHelpers
	def setup
		create_sample_file
	end

	def test_posifile
		client = Client.new
		client.build_attriubutes_from_hash
#		puts client.name
		assert_equal "jose", client.name
	end

	def test_posifile2
		client = Client.new
		client.build_attriubutes_from_hash
#		puts "cidade: "+client.name
		assert_equal "sorocaba", client.city
	end

	def test_field_value
	c = Client.new

	assert_equal "jose", c.field_value("name")
	end
end
