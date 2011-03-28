class Posifile
	@@specification = {}

	attr_accessor :data_file

	def self.set_specification(hash)
		@@specification = hash
	end

	def initialize(data_file_name)
		@data_file = data_file_name
		puts data_file
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
		range = @@specification[field_name]
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
		@@specification.each do |key, not_used|
			self.instance_eval "
				def #{key}
					\"#{field_value(key)}\"
				end
			"
		end
	end



end
