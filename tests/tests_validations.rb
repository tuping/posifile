require 'posifile'
require 'test/unit'
require 'test_helpers'
require 'models/models'

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
