class Player
	attr_accessor :hand, :name
	def initialize(name)
		@hand = []
		@name = name
	end
	
	def number_of_cards
		@hand.size
	end
	def play
		@hand.slice!(0)
	end
	def score
		@hand.size
	end
	def add_cards(input)
	inputs = input.scan(/([1234567890jqkaJQKA]+)[-_]?([CDSHcdsh])/)
	inputs.each do |c|
		@hand << Card.new(c[0],c[1])
	end

	end
end
