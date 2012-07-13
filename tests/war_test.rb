require 'test/unit'
require 'deck.rb'
require 'player.rb'
require 'game.rb'

class WarTest < Test::Unit::TestCase
	def test_card
		card1 = Card.new(4, "hearts")
		assert_equal(3,card1.value)
	end
	def test_deck
		game1 = Game.new(["John","Caleb"])
		assert_equal(52,game1.deck.number_of_cards)
		#print("Deck creation is functional.\n")
	end
	def test_deal
		game = Game.new(["John","Caleb"])
		game.deal
		
		assert_equal(52/game.players.size, game.players[0].number_of_cards)
		assert true, game.players[0].hand != game.players[1].hand
		#print("Deal is working correctly.\n")
	end
	
	def test_play
		player1 = Player.new("Doug")
		player1.hand << Card.new(2, "diamond")
		player1.play
		assert_equal(0,player1.score)
		#print("Play is functioning correctly.\n")
	end

	def test_force_lose
		game = Game.new(["Ken","Caleb"])
		game.players[0].hand << Card.new(8,"spades")
		game.players[0].hand << Card.new(9,"diamonds")
		game.players[0].hand << Card.new(10,"hearts")
		game.players[1].hand << Card.new(8,"clubs")
		3.times do game.play_round end
		assert_equal 4, game.players[0].score
		assert_equal 0, game.players[1].score
		#print("Game fails correctly when player runs out of cards in the middle of a war.\n")
	end
	
	def test_draw_and_pop
		game = Game.new(["Ken","Caleb"])
		game.deal
		card1 = game.players[0].hand[0]
		card2 = game.players[0].hand.shift
		assert_equal(card1, card2)
		card3 = game.players[0].hand << card1
		card4 = game.players[0].hand.last
		card5 = game.players[0].hand[-1]
		assert_equal(card5, card4)
		assert_equal(card5, card1)
		#print("shift and [0] are equivalent, as are shovel and [-1]\n")
	end

	def test_play_match
		game = Game.new(["John","Caleb"])
		game.deal
		
		while game.scores.max < 52
			game.play_round
			if game.scores.min == 0
				assert true, game.scores.max == 52
			end
			if game.rounds >10000 then
				solve = 0
				break print(game.scores.inspect, game.rounds, "\n")
			else
				solve = 1
			end

		end
		if solve == 1 then
		assert_equal 0, game.scores.min
		assert_equal 2, game.scores.uniq.size

		winner = game.scores.index(game.scores.max)
		print( "Winner: ", game.players[winner].name, ". Rounds Played: ", game.rounds, "\n")
		#print("Win conditions for 2 players working.\n")
		end
	end

	def test_play_many
		game = Game.new(["John", "Jay", "Josh", "Christian"])
		game.deal
		assert_equal 4, game.scores.size
		assert_equal Array, game.scores.class
		#puts game.scores.inspect
		while game.scores.max < 52
			game.play_round
			if game.rounds >10000 then
				solve = 0
				break print(game.scores.inspect, game.rounds, "\n")
			else
				solve = 1
			end
		end
		if solve == 1 then
		assert_equal 0, game.scores.min
		assert_equal 52, game.scores.max
		assert_equal 2, game.scores.uniq.size
		winner = game.scores.index(game.scores.max)
		print( "Winner: ", game.players[winner].name, ". Rounds Played: ", game.rounds, "\n")	
		end
		#print("Win conditions for 3+ players working.\n")
	end

end
