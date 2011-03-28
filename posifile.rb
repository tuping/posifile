class Posifile
	@@specification = {}

	attr_accessor :data_file

	def self.set_specification(hash)
		@@specification[self] ||= {}
		@@specification[self] = hash
	end

	def self.valid?(file_name)
		file  = File.open(file_name, "r")
		length = file.readline.length
		higher_number = higher
		if length == higher_number+1
			true
		else
			false
		end
	end

	def self.valid_specification?
		is_valid = gap_in_specification?
		# add mor validations here
	end

	def self.overlap_in_specification?
		num_ar = []
		@@specification[self].each_value do |range|
			range.each do |item|
				num_ar[item] ||= 0
				num_ar[item] += 1
			end
		end
		puts num_ar.inspect
		if num_ar.include?(2)
			return false
		else
			return true
		end
	end

	def self.gap_in_specification?
		num_ar = []
		@@specification[self].each_value do |range|
			range.each do |item|
				num_ar << true
			end
		end
		if num_ar.include? nil
			return false
		else
			return true
		end
	end

	def self.higher
		higher_number = 0
		@@specification[self].each_value do |range|
			if range.max > higher_number
					higher_number = range.max
			end
		end
		higher_number
	end

	def initialize(data_file_name)
		@data_file = data_file_name
		build_attriubutes_from_hash
	end

	def file_content
		file = File.open(@data_file,"r")
		file.readline
	end

	def field_value(field_name)
		content = file_content
		content_ar = content.split('')
		value_str = ''
		range = @@specification[self.class][field_name]
		range.each do |n|
				value_str.concat content_ar[n]
		end
		value_parse value_str
	end

	# get the value ignoring white spaces in th end of the string.
	def value_parse(value_string)
		ar = value_string.split(' ')
		ar.join(' ')
	end


	def build_attriubutes_from_hash
		@@specification[self.class].each do |key, not_used|
			self.instance_eval "
				def #{key}
					\"#{field_value(key)}\"
				end
			"
		end
	end



end
