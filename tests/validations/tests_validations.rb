require 'posifile'
require 'test/unit'
require 'test_helpers'

class WithGap <Posifile
	set_specification("name"=>0..10, 
											"city"=>11..31,
											"country"=>36..52
										)
end

class WithOverlap < Posifile
	set_specification("name"=>0..8, "address" => 8..20, "job" => 16..30)
end

class BothGapAndOverlap < Posifile
	set_specification("name"=>0..8, "address" => 10..20, "job" => 16..30)
end


class TestValidations < Test::Unit::TestCase

	include TestHelpers

	def test_valid_false
		assert !Client.valid?("samples/invalid.txt")
	end

	def test_valid_true
		assert Client.valid?("samples/sample.txt")
	end

	def test_valid_specification_false
		assert !WithGap.valid_specification?
	end

	def test_valid_specification_true
		assert Client.valid_specification?
	end

	def test_valid_specification_false
		assert !BothGapAndOverlap.valid_specification?
	end

	#especifics -------------
	def test_overlap_in_specification_false
		assert !WithOverlap.overlap_in_specification?
	end

	def test_overlap_in_specification_true
		assert Client.overlap_in_specification?
	end

	def test_gap_in_specification_false
		assert !WithGap.gap_in_specification?
	end

	def test_gap_in_specification_true
		assert Client.gap_in_specification?
	end
end
