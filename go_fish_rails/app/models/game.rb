class Game
 attr_accessor :deck, :players, :round, :rounds
	def initialize(names)
		@deck = DeckOfCards.new
		@players = names.collect {|name| Player.new(name)}
		@round = []
		@rounds = 0
	end
	
	def deal	
		@deck.shuffle
		endval = 52/@players.size
		@players.each do |player|
			endval.times {player.hand << @deck.draw}
		end
	end

	def scores
		@players.collect( &:score )
	end
	
	def play_round
		@rounds +=1
		@players.each do |player|
			if player.number_of_cards > 0
				@round << player.play
			else
				@round << Card.new(0,"")
			end
		end
		
		sorted = @round.slice(-@players.size,@players.size).sort! { |a,b| b.value <=> a.value }

		#sorted.sort! { |a,b| b.value <=> a.value }
		if sorted[0].value != sorted[1].value
			winner = @round.index(sorted[0]) % @players.size

			#print("Win: Player ", win , " ", @round.size, "\n")

			while @round.size > 0
				if @round[-1].value != 0
					@players[winner].hand << @round.pop
				else
					@round.delete_at(-1)
				end
			end

		else
			yield("\nI-DECLARE-WAR\n") if block_given?
			@players.each do |player|
				if player.number_of_cards > 0
					@round << player.play
				else
					@round << Card.new(0,"")
				end
			end
		end
		yield(self.scores.inspect) if block_given?
		#@players.each do |player|
			#	@scores << player.score
		#end	
	end
end
