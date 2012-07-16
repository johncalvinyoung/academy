class Card
	attr_accessor :rank, :suit
	def initialize(rank, suit)
		@rank = rank.to_s.upcase
		@suit = suit.upcase.slice(0..0)
	end
	def value
		%w(0 2 3 4 5 6 7 8 9 10 J Q K A).index(rank)
	end
end

class DeckOfCards
	attr_accessor :cards
	def initialize
		rank = ["2","3","4","5","6","7","8","9","10","J", "Q", "K", "A"]
		suit = ["C", "D", "S", "H"]  
		@cards = []
		rank.each do |rankOfCard|
			@cards << Card.new(rankOfCard, "C")
			@cards << Card.new(rankOfCard, "D")
			@cards << Card.new(rankOfCard, "S")
			@cards << Card.new(rankOfCard, "H")
		end
	end
  
	def draw
		@cards.shift
	end
  
	def number_of_cards
		@cards.size
	end

	def shuffle
		@cards.shuffle!
	end
end
