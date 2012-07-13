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
end
