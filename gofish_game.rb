class GoFishGame < Game
	attr_accessor :deck, :players, :current_player, :ui
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
		if scores.min == 0 then 
			ui.game_end(1)
			return true
		elsif @deck.number_of_cards == 0 then 
			ui.game_end(2)
			return true
		else
			return false
		end
	end

	def score
		win = @players.collect{|p| p.books.size}
		winner = win.find_index(win.max)
		if win.count{|s| s==win.max} > 1 then 
			ui.winner(@players.select{|p| p.books.size == win.max})
		else 
			ui.winner(@players[winner])
		end
		return @players[winner]
	end

	def play_full_game
		deal
		last = @players[0].take_turn_backup
		while end? == false do
			last = @players[@players.find_index(last)].take_turn_backup
			end
		winner = score
	end

	def start
		@current_player = players.sample
	end

	def play
		until end? do
			@current_player = @current_player.take_turn
		end
		winner = score
	end
end
