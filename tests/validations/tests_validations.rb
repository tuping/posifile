require 'posifile'
require 'test/unit'
require 'test_helpers'
require 'client'

class WithGap <Posifile
	set_specification("name"=>0..10, "city"=>11..31, "country"=>36..52)
end

class WithOverlap < Posifile
	set_specification("name"=>0..8, "address" => 8..20, "job" => 16..30)
end

class BothGapAndOverlap < Posifile
	set_specification("name"=>0..8, "address" => 10..20, "job" => 16..30)
end

class ValidClass < Posifile
	set_specification("name"=>0..8, "address" => 10..20, "job" => 16..30, "number"=>31..31)
end

class TestValidations < Test::Unit::TestCase

	include TestHelpers

	def test_valid_specification_gap_false
		assert !WithGap.valid_specification?
	end

	def test_valid_specification_true
		assert Client.valid_specification?
	end

	def test_valid_specification_overlap_false
		assert !WithOverlap.valid_specification?
	end

	def test_valid_specification_both_false
		assert !BothGapAndOverlap.valid_specification?
	end

	# specifics -------------
	def test_overlap_in_specification_false
		assert WithOverlap.overlap_in_specification?([{"name"=>0..8, "address" => 8..20, "job" => 16..30}])
	end

	def test_overlap_in_specification_true
		assert !Client.overlap_in_specification?([{"name"=>0..10, "city"=>11..31,"country"=>32..42}])
	end

	def test_gap_in_specification_false
		assert WithGap.gap_in_specification?([{"name"=>0..10, "city"=>11..31,"country"=>36..52}])
	end

	def test_gap_in_specification_true
		assert !Client.gap_in_specification?([{"name"=>0..10, "city"=>11..31,"country"=>32..42}])
	end

	def test_valid_class1
		assert !ValidClass.gap_in_specification?([{"name"=>0..10, "address" => 11..20, "job" => 21..30,"number"=>31..31}])
	end

	def test_valid_class2
		assert !ValidClass.gap_in_specification?([{"name"=>0..10, "address" => 11..20, "job" => 21..30,"number"=>31..31}])
	end
end
