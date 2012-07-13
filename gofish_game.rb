class GoFish < Game
	attr_accessor :deck, :players
	def initialize(names)
		@deck = DeckOfCards.new
		@players = names.collect {|name| GF_Player.new(name, self)}
	end

	def deal	
		@deck.shuffle
		@players.each { |player| 5.times {player.hand << @deck.draw} }
	end

	def end?
		scores = @players.collect{|p| p.hand.size}
		if scores.min == 0 then puts "A player ran out of cards.\n"
			return true
		elsif @deck.number_of_cards == 0 then puts "Deck ran out of cards.\n"
			return true
		else
			return false
		end
	end

	def score
		win = @players.collect{|p| p.books.size}
		winner = win.find_index(win.max)
		if win.count{|s| s==win.max} > 1 then print("There was a tie. No winner chosen.\n")
		else print("Winner: ", @players[winner].name, "! Books: ", @players[winner].books.size, ".\n")
		return @players[winner]
		end
	end

	def play_full_game
		deal
		last = @players[0].take_turn
		while end? == false do
			last = @players[@players.find_index(last)].take_turn
			end
		winner = score
	end
end
