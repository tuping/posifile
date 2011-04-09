require 'errors'
class Posifile

	INVALID_CHARS = " !@#$\%*()-\&\'\"<>.,;:[]{}\'\`^+\\/"

	@@specifications = {}
	@@conditions = {}
	@@attr_names = {}
	@@pos_attr = {}

	attr_accessor :data_file

	def initialize(data_file_name)
		@data_file = data_file_name

		check_specification_hash
		file_content.each do |line|
			if file_content.length == 1
				build_attributes_from_hash(@@specifications[self.class][0], line, nil)
			else
				specification_index(line) do |line_,index|
					build_attributes_from_hash(@@specifications[self.class][index], line_,@@attr_names[self.class][index])
				end
			end
		end
	end

	def self.set_specification(hash)
		@@attr_names[self] ||= []
		if valid_names?(hash)
			@@specifications[self] ||= []
			@@specifications[self] << hash
		else
			raise InvalidFieldName, "Fields names contain invalid characteres for method names."
		end
	end

	def self.lines_where(range,value,&block)
		@@attr_names[self] ||= []
		length_before = @@attr_names[self].length
		@@conditions[self] ||= []
		@@conditions[self] << {range,value}
		yield
		length_after = @@attr_names[self].length
		if length_before == length_after
			@@attr_names[self] << nil
		end
		section_code_hash = {"section_code"=>range}
		if @@specifications[self]
			@@specifications[self].last.merge!(section_code_hash)
		end
	end

	def self.set_attr_name(attr_name)
		@@attr_names[self] ||= []
		@@attr_names[self] << attr_name
	end

	def self.valid_names?(hash)
		check = true
		hash.each_key do |key|
			key.split('').each do |letter|
				unless letter.downcase == letter
					check = false
				end
				if INVALID_CHARS.split("").include?(letter)
					check = false
				end
			end
		end

		return check
	end

	def self.valid_specification?
		unless gap_in_specification?(@@specifications[self]) && overlap_in_specification?(@@specifications[self])
			false
		else
			true
		end
	end

	def self.overlap_in_specification?(spec_array)
		num_ar = []
		spec_array.each_with_index do |spec,index|
			spec.each_value do |range|
				range.each do |item|
					num_ar[index] ||= []
					num_ar[index][item] ||= 0
					num_ar[index][item] += 1
				end
			end
		end
		valid = true
		num_ar.each do |array|
			if array.include?(2)
				valid = false
			end
		end
		valid
	end

	def self.gap_in_specification?(spec_array)
		num_ar = []
		spec_array.each_with_index do |spec, index|
			spec.each_value do |range|
				range.each do |item|
					num_ar[index] ||= []
					num_ar[index][item] ||= 0
					num_ar[index][item] += 1
				end
			end
		end
		valid = true
		num_ar.each do |array|
			if array.include? nil
				valid = false
			end
		end
		valid
	end

	def self.higher
		higher_number = 0
		@@specifications[self][0].each_value do |range|
			if range.max > higher_number
					higher_number = range.max
			end
		end
		higher_number
	end

	def check_specification_hash
		if @@specifications[self.class].nil?
			raise FieldsNotSpecified, "You should call set_specifications in you model, so we can build the object with the corresponding attribuites. Check documentation on how to do so."
		end
	end

	def specification_index(line)
		i = 0
		unless @@conditions[self.class].nil?
			@@conditions[self.class].each_with_index do |hash, num|
				if check_condition(hash,line)
					yield line, num
				end
			end
		end
		i
	end

	def check_condition(condition_hash, checked_line)
			check = false
			condition_hash.each do |range, value|
				if checked_line[range] == value
					check = true
				end
			end
			check
	end

	def file_content
		file = File.open(@data_file,"r")
		file.readlines
	end

	def field_value(field_name,specification_hash,line)
		if field_name.class == Symbol
			field_name = field_name.to_s
		end
		content_ar = line.split('')
		value_str = ''
		if !specification_hash.keys.include? field_name 
			raise InvalidAttrName, "The specified attr name was not found in the specification hash."
		else
			range = specification_hash[field_name]

			range.each do |n|
					value_str.concat content_ar[n]
			end
			value_parse value_str
		end
	end

	# get the value ignoring white spaces in th end of the string.
	def value_parse(value_string)
		ar = value_string.split(' ')
		ar.join(' ')
	end

	def pos_attributes
		@@pos_attr[self.class]
	end

	def add_method_to_pos_attr(field)
		@@pos_attr[self.class] ||= []
		unless @@pos_attr[self.class].include? field
			@@pos_attr[self.class] << field
		end
	end

	# Once the name is gonna be used as method name, 
	# this changes the name when it contains invalid characters. 
	def change_name(original)
		original.gsub!(' ','_')
		INVALID_CHARS.split('').each do |char|
			original.gsub!(char,'')
		end
		original.downcase
	end

	def build_attributes_from_hash(specification_hash,line,attr_name)
		unless attr_name.nil?
			values_hash = {}
			specification_hash.each do |key, value|
				values_hash[key] = field_value(key, specification_hash, line )
			end

			method_name = change_name(field_value(attr_name,specification_hash,line))

			add_method_to_pos_attr(method_name)
			self.instance_eval "
				def #{method_name}\n
					#{values_hash.inspect}\n
				end
			"
		else
			specification_hash.each do |key, not_used|
					add_method_to_pos_attr(key)
					self.instance_eval "
						def #{key}
							\"#{field_value(key, specification_hash, line)}\"
						end
					"
			end
		end
	end

end
