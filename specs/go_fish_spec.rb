require 'test/unit'
require_relative '../deck.rb'
require_relative '../player.rb'
require_relative '../game.rb'
require_relative '../block.rb'
require_relative '../gofish_player.rb'
require_relative '../gofish_game.rb'
require_relative '../user_interface.rb'
require_relative '../playerui.rb'


describe GoFishGame do
	it "should be set up" do
		@game = GoFishGame.new(["Christian", "John", "Caleb", "Hope"])
		@game.class.should eq(GoFishGame)
	end
	it "should deal" do
		game = GoFishGame.new(["Christian", "John", "Caleb"])
		game.deal
		game.players[0].class.should eq(GF_Player)
		game.players[0].number_of_cards.should eq(5)
		game.deck.number_of_cards.should eq(37)
		game.players[0].opponents.size.should eq(2)
	end
	it "should create the pond correctly, and draw a card from it" do
		game = GoFishGame.new(["Jay", "John", "Christian"])
		game.deal
		
		card1 = game.deck.draw

		game.deck.number_of_cards.should eq(36)
		card1.class.should eq(Card)
	end
	it "should let the players know about the game" do
		game = GoFishGame.new(["Christian", "Bob", "Christiana"])
		game.deal
		game.players[0].mygame.deck.number_of_cards.should eq(37)
	end
	it "should have the player give a card when asked" do
		player1 = GF_Player.new("Jay", nil)
		player1.add_cards("4H 4C 5H")

		give1 = player1.give("4")
		give2 = player1.give("A")

		give1.size.should eq(2)
		give2.size.should eq(0)
		player1.number_of_cards.should eq(1)
	end
	it "should have the player play a round" do
		game = GoFishGame.new(["John","Jay","Christian"])
		players = game.players
		players[0].add_cards("4H 4C 5D")
		players[1].add_cards("4S 6S 7H")

		game.players[0].take_turn_backup

		game.players[0].hand.select{|c| c.rank=='4'}.size.should eq(3)
		game.players[0].hand.size.should eq(5)
		game.players[0].books.size.should eq(0)
		game.players[1].hand.select{|c| c.rank == '4'}.size.should eq(0)
	end
	it "should have a player play a round and win a block" do
		game = GoFishGame.new(["John","Jay","Christian"])
		players = game.players
		players[0].add_cards("4H 4C 5D")
		players[1].add_cards("4S 6S")
		players[2].add_cards("7H 4D")
		
		last = game.players[0].take_turn_backup

		game.players[0].hand[0].class.should eq(Card)
		game.players[0].hand.select{|c| c.rank=='4'}.size.should eq(0)
		game.players[0].hand.size.should eq(1)
		game.players[0].books.size.should eq(1)
	end
	it "should have conditions so the game is winnable" do
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
		
		if winner.nil? == false then game.players.collect{|p| p.books.size}.max.should eq(winner.books.size) end
	end
	it "should play a full game on command and yield a winner" do
		game = GoFishGame.new(["Hope","Caleb","Joshua"])
		game.ui = UserInterface.new		
		winner = game.play_full_game
		winner.class.should equal GF_Player
	end
end

describe UserInterface do
	before(:each) do
		@ui = UserInterface.new
		@ui.start(4)
	end
	it "should let the game know about the ui" do
		@ui.game.players.size.should equal 4
		@ui.class.should equal UserInterface
		@ui.game.current_player.should_not equal nil
		@ui.game.ui.should equal @ui
	end
	it "should have a UI for every player" do
		@ui.game.players.each do |player|
			player.ui.should_not equal nil
		end
	end
	it "should have a human player" do
		humans = @ui.game.players.reject{|p| p.ui.class == GoFishRobotPlayerUI}
		humans[0].ui.class.should equal GoFishCLIPlayerUI
	end
	it "should successfully compare cards, without breaking hash" do
		ace_spades_1 = Card.new('A', 'Spades') 
		ace_spades_2 = Card.new('A', 'Spades') 
		hash = {ace_spades_1 => 'WILD'}

		(ace_spades_1==ace_spades_2).should equal true
		ace_spades_1.should eq(ace_spades_2)
		(hash[ace_spades_2]=='WILD').should equal true
	end
end
