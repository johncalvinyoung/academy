class GF_Player < Player
	attr_accessor :hand, :name, :books, :mygame
	def initialize(name, game)
		@hand = []
		@name = name
		@books = []
		@mygame = game
	end

	def opponents
		mygame.players.select{|p| p != self}	
	end

	def give(rank)
		requested = hand.select{|c| c.rank==rank}
		@hand -= requested
		if requested.size != 0 then return requested else return [] end
	end

	def take_turn
		top_rank = search_for_top_rank
		#@opponents.shuffle! #this line randomizes first player to ask for a card
		last_player_asked = nil
		opponents.each do |opponent|
			last_player_asked = opponent
			cards = opponent.give(top_rank)
			if cards != [] then yield([name, " received a ", cards.first.rank, ".\n"]) if block_given?
			cards.each {|c| hand << c}
			else card = mygame.deck.draw
				if card != nil then yield([name, " drew a ", card.rank, ".\n"]) if block_given?
					hand << card
				else return end
				break if card.rank != top_rank
			end
			if number_of_cards("4") == 4 then
				@books << Book.new(top_rank)
				hand.delete_if{|c| c.rank == top_rank}
				if hand.size != 0 then top_rank = search_for_top_rank else return end
			end	
		end
		return last_player_asked
	end

	def search_for_top_rank
		#used code for determining the mode of the distribution from StackOverflow
		hand.group_by(&:rank).sort_by{|a,b| b.size<=>a.size}.last[0]
	end

	def number_of_cards(*rank)
		if rank != [] then
		return hand.select{|c| c.rank == rank[0]}.size
		else
		return hand.size
		end
	end
end
