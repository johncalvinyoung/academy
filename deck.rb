class Card
	attr_accessor :rank, :suit
	def initialize(rank, suit)
		@rank = rank.to_s
		@suit = suit
	end
	def value
		%w(0 2 3 4 5 6 7 8 9 10 Jack Queen King Ace).index(rank)
	end
end

class DeckOfCards
	attr_accessor :cards
	def initialize
		rank = ["2","3","4","5","6","7","8","9","10","Jack", "Queen", "King", "Ace"]
		suit = ["clubs", "diamonds", "spades", "hearts"]  
		@cards = []
		rank.each do |rankOfCard|
			@cards << Card.new(rankOfCard, "clubs")
			@cards << Card.new(rankOfCard, "diamonds")
			@cards << Card.new(rankOfCard, "spades")
			@cards << Card.new(rankOfCard, "hearts")
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
