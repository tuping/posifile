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

	def create_one_line_sample
		create_folder
		unless File.exist?("samples/one_line_sample.txt")
			content = "001yellow    "
			sample = File.new("samples/one_line_sample.txt","wb")
			sample.puts content
			sample.close
		end
	end

	def create_two_lines_sample
		create_folder
		unless File.exist?("samples/multi_line_sample.txt")
			content = <<END
001uno       yellow    
002yamaha    blue      
001vectra    white     
002harley    black     
001fusca     BEGE      
END
			sample = File.new("samples/multi_line_sample.txt","wb")
			sample.puts content
			sample.close
		end
	end


end
