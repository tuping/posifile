require 'posifile'
require 'test/unit'
require 'test_helpers'

class Client < Posifile 
	set_data_file "sample.txt"
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>32..42
										)
end

class TestPosifile < Test::Unit::TestCase

	include TestHelpers

	def setup
		create_sample_file
	end

	def test_posifile
		client = Client.new
		client.build_attriubutes_from_hash
		assert_equal "jose", client.name
	end

	def test_posifile2
		client = Client.new
		client.build_attriubutes_from_hash
		assert_equal "new york", client.city
	end

	def test_value_parse
		c = Client.new

		assert_equal "esta frase precisa estar completa !", c.value_parse("esta frase precisa estar completa !                 ")
	end

	def test_field_value
	c = Client.new

	assert_equal "jose", c.field_value("name")
	end
end
