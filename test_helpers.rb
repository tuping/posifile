module TestHelpers
	def create_sample_file
		content = "jose       new york             brazil    "
		sample = File.new("samples/sample.txt","wb")
		sample.puts content
		sample.close
	end

	def create_sample_file2
		content = "Richard    New Orleans          USA        "
		sample = File.new("samples/sample2.txt","wb")
		sample.puts content
		sample.close
	end

	def create_sample_invalid
		content = "Richard  New Orleans        USA      "
		sample = File.new("samples/invalid.txt","wb")
		sample.puts content
		sample.close
	end

end
