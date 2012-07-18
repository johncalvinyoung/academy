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
	if input.is_a?(String) then cards = input.scan(/\b([2-9JQKA]|10)\w*[-_]*([CDSH])/i)
	elsif input.is_a?(Card) then cards = [input]
	else cards = input end
		cards.each do |c|
		if c.class == Card then hand << c else
			hand << Card.new(c[0],c[1])
		end
	end

	end
end
