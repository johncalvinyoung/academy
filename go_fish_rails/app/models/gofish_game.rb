require 'deck'
require 'game'
require 'player'
require 'gofish_player'
require 'block'


class GoFishGame < Game
	attr_accessor :deck, :players, :current_player, :ui, :key, :messages
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
			add_message("Game over: a player ran out of cards.<br \>")
			return true
		elsif @deck.number_of_cards == 0 then 
			add_message("Game over: the deck ran out of cards.<br \>")
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
		#return @players[winner]
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

	def as_json
	  playersarray = []
	  @players.each do |player|
	    playersarray << player.as_json
	  end
	  return {"deck" => @deck.as_json, "players" => playersarray, "current_player" => @current_player.as_json, "key" => @key, "messages" => @messages}
	end
	def to_json
	  return self.as_json.to_json
	end

	def self.from_json json_string
	  hash = JSON.parse json_string
	  @game = GoFishGame.new([hash["players"][0]["name"],hash["players"][1]["name"],hash["players"][2]["name"],hash["players"][3]["name"]])
	  @game.deck.cards = []
	  hash["deck"]["cards"].each do |card|
	    @game.deck.cards << Card.new(card["rank"],card["suit"])
	  end
	  hash["players"].each do |saved_player|
	    player = GF_Player.new(saved_player["name"],@game)
	    saved_player["hand"].each do |card|
	      player.hand << Card.new(card["rank"],card["suit"])
	    end
	    player.name = saved_player["name"]
	    saved_player["books"].each do |book|
	      player.books << Book.new(book)
	    end
	    @game.players << player
	  end
	  current_player_index = @game.players.find_index{|p| p.name == hash["current_player"]["name"] && p.books.size == hash["current_player"]["books"].size}
	  @game.current_player = @game.players[current_player_index]
	  @game.key = hash["key"]
	  @game.messages = hash["messages"]
	  return @game
	end
end