require 'test/unit'
require_relative '../deck.rb'
require_relative '../player.rb'
require_relative '../game.rb'
require_relative '../block.rb'
require_relative '../gofish_player.rb'
require_relative '../gofish_game.rb'
require_relative '../user_interface.rb'
require_relative '../playerui.rb'

class GoFishTest < Test::Unit::TestCase
	def setup
		@game = GoFishGame.new(["Christian", "John", "Caleb", "Hope"])

	end

	def test_game_and_deal
		game = GoFishGame.new(["Jay", "John", "Christian"])
		game.deal
		
		assert_equal GF_Player, game.players[0].class
		assert_equal 5, game.players[0].number_of_cards
		assert_equal 37, game.deck.number_of_cards
		assert_equal 2, game.players[0].opponents.size
	end

	def test_pond
		game = GoFishGame.new(["Jay", "John", "Christian"])
		game.deal
		
		card1 = game.deck.draw
		assert_equal 36, game.deck.number_of_cards
		assert_equal Card, card1.class

	end

	def test_player_knows_about_game
	
		game = GoFishGame.new(["Christian", "Bob", "Christiana"])
		game.deal

		assert_equal 37, game.players[0].mygame.deck.number_of_cards

	end

	def test_player_gives_card_when_asked
		player1 = GF_Player.new("Jay", nil)
		player1.add_cards("4H 4C 5H")

		give1 = player1.give("4")
		give2 = player1.give("A")

		assert_equal 2, give1.size
		assert_equal 0, give2.size
		assert_equal 1, player1.number_of_cards
	end

	def test_player_plays_round
		game = GoFishGame.new(["John","Jay","Christian"])
		players = game.players
		players[0].add_cards("4H 4C 5D")
		players[1].add_cards("4S 6S 7H")

		game.players[0].take_turn_backup
		
		assert_equal 3, game.players[0].hand.select{|c| c.rank=='4'}.size
		assert_equal 5, game.players[0].hand.size
		assert_equal 0, game.players[0].books.size
		assert_equal 0, game.players[1].hand.select{|c| c.rank == '4'}.size
		puts "test_player_round"
	end

	def test_player_plays_round_wins_block
		game = GoFishGame.new(["John","Jay","Christian"])
		players = game.players
		players[0].add_cards("4H 4C 5D")
		players[1].add_cards("4S 6S")
		players[2].add_cards("7H 4D")
		
		last = game.players[0].take_turn_backup

		assert_equal Card, game.players[0].hand[0].class
		assert_equal 0, game.players[0].hand.select{|c| c.rank=='4'}.size
		assert_equal 1, game.players[0].hand.size
		assert_equal 1, game.players[0].books.size
		puts "test_player_plays_round_wins_block"
	end

	def test_game_won
		game = GoFishGame.new(["Matt", "Sam", "Seth", "David", "Susanna", "Katie"])
		game.deal
		game.ui = UserInterface.new
		starting_player = rand(game.players.size)
		last = game.players[starting_player].take_turn_backup
		while game.end? == false do
			index = game.players.find_index(last)
			last = game.players[index].take_turn_backup # enable for verbose game mode
			end
		winner = game.score
		
		if winner.nil? == false then assert_equal game.players.collect{|p| p.books.size}.max, winner.books.size end
		puts "test_game_won"
	end

	def test_play_full_game
		game = GoFishGame.new(["Hope","Caleb","Joshua"])
		game.ui = UserInterface.new		
		game.play_full_game
		puts "test_play_full_game"
	end

end

class GoFishUserInterfaceTest < Test::Unit::TestCase
	def setup
		@ui = UserInterface.new
		@ui.start(4)

	end

	def test_Game_has_ui
		assert_equal(4, @ui.game.players.size)
		assert @ui.class == UserInterface
		assert_not_nil(@ui.game.current_player)
		assert_equal(@ui,@ui.game.ui)
	end

	def test_current_player_ui_drives_turn
		@ui.game.players.each do |player|
			assert_not_nil(player.ui)
		end
	end

	def test_game_human_player
		humans = @ui.game.players.reject{|p| p.ui.class == GoFishRobotPlayerUI}
		assert_equal(GoFishCLIPlayerUI, humans[0].ui.class)
	end

	def test_hash_conditions
		ace_spades_1 = Card.new('A', 'Spades') 
		ace_spades_2 = Card.new('A', 'Spades') 
		hash = {ace_spades_1 => 'WILD'}

		assert(ace_spades_1 == ace_spades_2)
		assert_equal(ace_spades_1, ace_spades_2)
		assert_equal('WILD', hash[ace_spades_2])
	end
end
