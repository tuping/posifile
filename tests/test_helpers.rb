module TestHelpers
	def create_folder
		Dir.mkdir("samples/") unless File.directory? "samples/"
	end

	def create_sample_file
		create_folder
		content = "jose       new york             brazil    "
		sample = File.new("samples/sample.txt","wb")
		sample.puts content
		sample.close
	end

	def create_sample_file2
		create_folder
		content = "Richard    New Orleans          USA        "
		sample = File.new("samples/sample2.txt","wb")
		sample.puts content
		sample.close
	end

	def create_sample_invalid
		create_folder
		content = "Richard  New Orleans        USA      "
		sample = File.new("samples/invalid.txt","wb")
		sample.puts content
		sample.close
	end

	def create_car_sample
		create_folder
		content = "001yellow    002blue      "
		sample = File.new("samples/car_sample.txt","wb")
		sample.puts content
		sample.close
	end

end
