class GF_Player < Player
	attr_reader :id
	attr_accessor :hand, :name, :books, :mygame, :ui, :decision
	def initialize(name, game)
		@hand = []
		@name = name
		@books = []
		@mygame = game
		@decision = nil
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
		#return ui.take_turn
		command = self.decision
  		next_player = self
		opponent = command[0]
		rank = command[1]
	  	cards = opponent.give(rank)
		mygame.add_message("#{mygame.current_player.name} asked #{opponent.name} for all his #{rank}s<br \>")		
	  	if cards != [] then
			cards.each {|c| hand << c}
			mygame.add_message("#{mygame.current_player.name} received #{cards.size} #{rank}s from #{opponent.name}<br \>")
		else 
	       		card = mygame.deck.draw
			if card != nil then
				mygame.add_message("GO FISH\n")
				mygame.add_message("#{mygame.current_player.name} drew from the deck.<br \>")
				hand << card
				if card.rank != rank then next_player = opponent end
			end
		end
		check_for_books
     		return next_player
	end

	def check_for_books
		handrank = hand.group_by(&:rank)
		#p handrank.select{|r| handrank[r].size == 2}
		hand.group_by(&:rank).select{|r| handrank[r].size == 4}.each do |bookrank|
			@books << Book.new(bookrank[0])
			mygame.add_message("#{mygame.current_player.name} got a book of #{bookrank[0]}s<br \>")
	       		hand.delete_if{|c| c.rank == bookrank[0]}
		end
	end

	def take_turn_backup
		top_rank = search_for_top_rank
		#@opponents.shuffle! #this line randomizes first player to ask for a card
		last_player_asked = nil
		opponents.each do |opponent|
			last_player_asked = opponent
			cards = opponent.give(top_rank)
			if cards != [] then yield([name, " received a ", cards.first.rank, ".\n"]) if block_given?
			cards.each {|c| hand << c}
			else 
#				print("GO FISH:\n")
				card = mygame.deck.draw
				if card != nil then
					print(name, " received a ", card.rank, "!\n")
					hand << card
				else
					print("The deck is out of cards and the game is over!\n")
				return end
				break if card.rank != top_rank
			end
			if number_of_cards(top_rank) == 4 then
				@books << Book.new(top_rank)
				print(name, " got a book of ", top_rank, "'s!\n")
				hand.delete_if{|c| c.rank == top_rank}
				if hand.size != 0 then
					top_rank = search_for_top_rank 
					else
						print(name, " is out of cards and the game is over!\n")	
					return end
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
	def id
	  mygame.players.find_index(self)
	end

end
