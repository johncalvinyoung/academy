require 'test/unit'
require 'deck.rb'
require 'player.rb'
require 'game.rb'
require 'block.rb'
require 'gofish_player.rb'
require 'gofish_game.rb'

class GoFishTest < Test::Unit::TestCase

	def test_game_and_deal
		game = GoFish.new(["Jay", "John", "Christian"])
		game.deal
		
		assert_equal GF_Player, game.players[0].class
		assert_equal 5, game.players[0].number_of_cards
		assert_equal 37, game.deck.number_of_cards
		assert_equal 2, game.players[0].opponents.size
	end

	def test_pond
		game = GoFish.new(["Jay", "John", "Christian"])
		game.deal
		
		card1 = game.deck.draw
		assert_equal 36, game.deck.number_of_cards
		assert_equal Card, card1.class

	end

	def test_player_knows_about_game
	
		game = GoFish.new(["Christian", "Bob", "Christiana"])
		game.deal

		assert 37, game.players[0].mygame.deck.number_of_cards

	end

	def test_player_gives_card_when_asked
		player1 = GF_Player.new("Jay", nil)
		player1.hand << Card.new(4, "hearts")
		player1.hand << Card.new(4, "clubs")
		player1.hand << Card.new(5, "hearts")

		give1 = player1.give("4")
		give2 = player1.give("Ace")

		assert_equal 2, give1.size
		assert_equal 0, give2.size
		assert_equal 1, player1.number_of_cards
	end

	def test_player_plays_round
		game = GoFish.new(["John","Jay","Christian"])
		game.players[0].hand << Card.new(4, "hearts")
		game.players[0].hand << Card.new(4, "clubs")
		game.players[0].hand << Card.new(5, "diamonds")
		game.players[1].hand << Card.new(4, "spades")
		game.players[1].hand << Card.new(6, "spades")
		game.players[2].hand << Card.new(7, "hearts")

		game.players[0].take_turn
		
		assert_equal 3, game.players[0].hand.select{|c| c.rank=='4'}.size
		assert_equal 5, game.players[0].hand.size
		assert_equal 0, game.players[0].books.size
		assert_equal 0, game.players[1].hand.select{|c| c.rank == '4'}.size
	end

	def test_player_plays_round_wins_block
		game = GoFish.new(["John","Jay","Christian"])
		game.players[0].hand << Card.new(4, "hearts")
		game.players[0].hand << Card.new(4, "clubs")
		game.players[0].hand << Card.new(5, "diamonds")

		game.players[1].hand << Card.new(4, "spades")
		game.players[1].hand << Card.new(6, "spades")

		game.players[2].hand << Card.new(7, "hearts")
		game.players[2].hand << Card.new(4, "diamonds")
		
		last = game.players[0].take_turn

		assert_equal Card, game.players[0].hand[0].class
		assert_equal 0, game.players[0].hand.select{|c| c.rank=='4'}.size
		assert_equal 1, game.players[0].hand.size
		assert_equal 1, game.players[0].books.size
	end

	def test_game_won
		game = GoFish.new(["Matt", "Sam", "Seth", "David", "Susanna", "Katie"])
		game.deal
		starting_player = rand(game.players.size)
		last = game.players[starting_player].take_turn
		while game.end? == false do
			index = game.players.find_index(last)
			last = game.players[index].take_turn {|x| print(x)} # enable for verbose game mode
			end
		winner = game.score
		
		if winner.nil? == false then assert_equal game.players.collect{|p| p.books.size}.max, winner.books.size end
	end

	def test_play_full_game
		game = GoFish.new(["Hope","Caleb","Joshua"])
		game.play_full_game
	end
end
