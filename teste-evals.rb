class Client

	def create_method
		Client.class_eval{def name; "jose"; end}
	end
end



c = Client.new
c.create_method
puts c.name
