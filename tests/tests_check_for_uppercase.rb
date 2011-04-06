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

	def tests_check_for_uppercase_true2
		assert !UppercasedSpec.check_for_uppercase("nome_do_arquivo"=>2..14,"codigo_de_origem"=>15..22,"data_de_geracao_do_arquivo"=>23..30)
	end

#	def tests_check_for_uppercase_false2
#		assert !UppercasedSpec.check_for_uppercase("nome do arquivo"=>2..14,"codigo"=>15..22,"data"=>23..30)
#	end
end
