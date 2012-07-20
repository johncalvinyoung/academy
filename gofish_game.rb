class GoFishGame < Game
	attr_accessor :deck, :players, :current_player, :ui, :key
	def initialize(names)
		@deck = DeckOfCards.new
		@players = names.collect {|name| GF_Player.new(name, self)}
		@key = ""
		@messages = ""
	end

	def deal	
		@deck.shuffle
		@players.each { |player| 5.times {player.hand << @deck.draw} }
	end

	def end?
		scores = @players.collect{|p| p.hand.size}
		if scores.min == 0 then 
			add_message("Game over: a player ran out of cards.<br />")
			return true
		elsif @deck.number_of_cards == 0 then 
			add_message("Game over: the deck ran out of cards.<br />")
			return true
		else
			return false
		end
	end

	def score
		win = @players.collect{|p| p.books.size}
		winner = win.find_index(win.max)
		if win.count{|s| s==win.max} > 1 then 
			@players.select{|p| p.books.size == win.max}
		else 
			@players[winner]
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
		@current_player = players[0] #players.sample
	end

	def play
		until end? do
			@current_player = @current_player.take_turn
		end
	end
	def end
		winner = score
	end
	def add_message(msg)
	  @messages = @messages + msg
	end
	def clear_messages
	  @messages = ""
	end
	def messages
	  return @messages
	end
end
