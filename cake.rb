class Cake
	attr_reader :name, :description, :price, :image

	def initialize(name, description, price, image)
		@name = name
		@description = description
		@price = price
		@image = image
	end
end
