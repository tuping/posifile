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

	def create_car1_sample
		create_folder
		unless File.exist?("samples/car1_sample.txt")
			content = "001yellow    "
			sample = File.new("samples/car1_sample.txt","wb")
			sample.puts content
			sample.close
		end
	end

	def create_car2_sample
		create_folder
		unless File.exist?("samples/car2_sample.txt")
			content = "001yellow    \n002blue      "
			sample = File.new("samples/car2_sample.txt","wb")
			sample.puts content
			sample.close
		end
	end


end
