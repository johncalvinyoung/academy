require 'digest/md5'
class Card
	attr_accessor :rank, :suit
	def initialize(rank, suit)
		@rank = rank.to_s.upcase
		@suit = suit.upcase.slice(0..0)
	end
	def value
		%w(0 2 3 4 5 6 7 8 9 10 J Q K A).index(rank)
	end

	  def ==(other)
	       return self.rank == other.rank && self.suit == other.suit if other.class == Card
	       return super == other if other.class != Card
	  end

	  def eql?(other)
	       return self.rank == other.rank && self.suit == other.suit if other.class == Card
	       return super.eql?(other) if other.class != Card
	  end

	  def hash
	       return (rank+suit).hash
	  end
end

class DeckOfCards
	attr_accessor :cards
	def initialize
		rank = ["2","3","4","5","6","7","8","9","10","J", "Q", "K", "A"]
		suit = ["C", "D", "S", "H"]  
		@cards = []
		rank.map{|r| suit.map {|s| @cards << Card.new(r,s)}}
		return @cards
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
