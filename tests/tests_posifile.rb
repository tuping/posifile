require 'posifile'
require 'test/unit'
require 'test_helpers'

class Client < Posifile 
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>32..42
										)
end

class NoSpec < Posifile
end

class TestPosifile < Test::Unit::TestCase
# Here are general tests

	include TestHelpers

	def setup
		create_sample_file
		create_sample_file2
		create_sample_invalid
	end

	def test_posifile
		client = Client.new("samples/sample.txt")
		assert_equal "jose", client.name
	end

	def test_posifile2
		client = Client.new("samples/sample2.txt")
		assert_equal "New Orleans", client.city
	end

	def test_posifile_with_two_objects
		client1 = Client.new("samples/sample.txt")
		client2 = Client.new("samples/sample2.txt")
		assert_equal "jose", client1.name
		assert_equal "New Orleans", client2.city
	end

	def test_value_parse
		c = Client.new("samples/sample.txt")
		assert_equal "esta frase precisa estar completa !", c.value_parse("esta frase precisa estar completa !                 ")
	end

	def test_field_value
		c = Client.new("samples/sample.txt")
		assert_equal "jose", c.field_value("name",{"name"=>0..10, "city"=>11..31, "country"=>32..42}, "jose       new york             brazil    ")
	end

	def test_higher
		assert_equal 42, Client.higher
	end

	def test_no_spec_model
		assert_raise(FieldsNotSpecified) do
			no_spec = NoSpec.new("samples/sample.txt")
		end
	end

	def test_pos_attributes
		c = Client.new("samples/sample.txt")
		puts c.pos_attributes
		assert c.pos_attributes.include? "city"
		assert c.pos_attributes.include? "name"
		assert c.pos_attributes.include? "country"
		assert_equal 3, c.pos_attributes.length
	end
end
