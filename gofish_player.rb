class GF_Player < Player
	attr_accessor :hand, :name, :books, :mygame, :ui
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
		#return ui.take_turn
		command = ui.ask_for_input
		next_player = self
		opponent = command[0]
		rank = command[1]
	  	cards = opponent.give(rank)
	  	if cards != [] then
			cards.each {|c| hand << c}
			ui.received(opponent, cards.size, rank)
	  	else 
	       		card = mygame.deck.draw
			if card != nil then
				ui.go_fish(card.rank)
				hand << card
				if card.rank != rank then next_player = opponent end
			end
		end
		#check for books
		#check_for_books(rank)
		if number_of_cards(rank) == 4 then
	       		@books << Book.new(rank)
			ui.got_books(rank)
	       		hand.delete_if{|c| c.rank == rank}
		end	
     		return next_player
	end

	def check_for_books(rank)
		if number_of_cards(rank) == 4 then
	       		@books << Book.new(rank)
			ui.got_books
	       		hand.delete_if{|c| c.rank == rank}
		end
	end

	def take_live_turn
		players_turn = true
		while players_turn == true do

			puts "\nWho do you want to ask for which card?\n"
			puts "Example: \"ask Matt for 3's\n"
			hand_dump = ""
			hand.sort{|a,b| a.value <=> b.value}.each{|c| hand_dump += " "+c.rank}
			puts hand_dump
			command = gets.chomp.scan(/ask\s*(\w+)\s*for\s*([2-9JKQAjqka]|10)/i)
			opponent = mygame.players.find_index{|p| p.name == command[0][0]}
			if mygame.players[opponent] == self then
				puts "You cannot ask yourself for cards!\n"
				next
			elsif hand.select{|c| c.rank == command[0][1]}.size == 0
				puts "You cannot ask for a rank which you do not possess!\n"
				next
			end
			reply = mygame.players[opponent].give(command[0][1])
			last_player_asked = mygame.players[opponent]

			if reply != [] then 
				print(mygame.players[opponent].name, " gave you ", reply.size, " ", command[0][1], "s\n")
				reply.each {|c| hand << c}
			else 
				card = mygame.deck.draw
				print("GO FISH:\n")
				print("You received a ", card.rank, "!\n")
				if card != nil then
					hand << card
				else
					puts "The deck is out of cards and the game is over!\n"
				return end
				if card.rank != command[0][1] then
					players_turn = false
				break
				end
			end
			if number_of_cards(command[0][1]) == 4 then 
				@books << Book.new(command[0][1])
				print("You got a book of ", command[0][1], "'s!\n")
				hand.delete_if{|c| c.rank == command[0][1]}
				if hand.size == 0 then
					print("You are out of cards, and the game is over!\n")
					return
				end
			end

		end
		return last_player_asked
	end

	def take_universal_turn
		players_turn = true
		while players_turn == true do
			command = ui.ask_for_input
			ui.ask(self, mygame.players[command[0]], command[1])
			reply = mygame.players[command[0]].give(command[1])
			print reply
			last_player_asked = mygame.players[command[0]]

			if reply != [] then 
				ui.gave(mygame.players[opponent], self, reply.size, command[1])
				reply.each {|c| hand << c}
			else 
				card = mygame.deck.draw
				ui.go_fish(self, card.rank)
				if card != nil then
					hand << card
				else
					ui.game_end(mygame.deck)
					return 
				end
				if card.rank != command[1] then
					players_turn = false
				break
				end
			end
			if number_of_cards(command[1]) == 4 then 
				@books << Book.new(command[1])
				ui.notify_book(command[1])
				hand.delete_if{|c| c.rank == command[1]}
				if hand.size == 0 then
					ui.game_end(self)
					return
				end
			end

		end
		return last_player_asked
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
end
