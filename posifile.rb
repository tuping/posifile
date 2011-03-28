class Posifile
	@@data_file = ''
	@@specification = {}

	def self.set_specification(hash)
		@@specification = hash
	end
	
	def self.set_data_file(path_to_file)
		@@data_file = path_to_file
	end

	def file_content
		file = File.open(@@data_file,"r")
		file.readline
	end

	def field_value(field_name)
		content = file_content
		content_ar = content.split('')
		value = ''
		range = @@specification[field_name]
		range.each do |n|
				value.concat content_ar[n]
		end
		value.split(' ')[0]
	end
	

	def build_attriubutes_from_hash
		@@specification.each do |key, not_used|
			Posifile.class_eval "
				def #{key}
					\"#{field_value(key)}\"
				end
			"
		end
	end



end
