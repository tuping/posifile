module TestHelpers
	def create_sample_file
		content = "jose       sorocaba            brazil     "
		sample = File.new("sample.txt","wb")
		sample.puts content
		sample.close
	end
	def delete_sample_file
	end
end
