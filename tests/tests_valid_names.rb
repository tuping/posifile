require 'posifile'
require 'test/unit'
require 'test_helpers'

class UppercasedSpec < Posifile 
end

class TestsCheckForUppercase < Test::Unit::TestCase

	include TestHelpers

	def setup
	end

	def tests_valid_names_false
		assert !UppercasedSpec.valid_names?({"Name"=>1..10, "CITY"=>11..20, "country"=>21..32})
	end

	def tests_valid_names_true
		assert UppercasedSpec.valid_names?({"name"=>1..10, "city"=>11..20, "country"=>21..32})
	end

	def tests_valid_names_true2
		assert UppercasedSpec.valid_names?("nome_do_arquivo"=>2..14,"codigo_de_origem"=>15..22,"data_de_geracao_do_arquivo"=>23..30)
	end

	def tests_valid_names_false2
		assert !UppercasedSpec.valid_names?("nome do arquivo"=>2..14,"codigo"=>15..22,"data"=>23..30)
	end
end
