		require 'deck.rb'
		require 'player.rb'
		require 'game.rb'
		require 'block.rb'
		require 'gofish_player.rb'
		require 'gofish_game.rb'
		require 'playerui.rb'
		
		game = GoFish.new(["Matt", "Sam", "Seth"])
		game.deal
		player = 0
		last = game.players[player].take_universal_turn	
		while game.end? == false do
			index = game.players.find_index(last)
			last = game.players[player].take_universal_turn
		end
		winner = game.score
