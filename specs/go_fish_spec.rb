require_relative '../deck.rb'
require_relative '../player.rb'
require_relative '../game.rb'
require_relative '../block.rb'
require_relative '../gofish_player.rb'
require_relative '../gofish_game.rb'
require_relative '../user_interface.rb'
require_relative '../playerui.rb'
#require 'spec_helper'

describe GoFishGame do
	describe "setup" do
		subject do
			@game = GoFishGame.new(["John", "Jay", "Ken", "Christian"])
			@game.deal
			@game
		end
		it "should create players" do
			subject.players[0].class.should eq(GF_Player)
			subject.players.select{|p| p.class==GF_Player}.size.should eq(4)
		end
		it "should create a deck and deal it out" do
			subject.deck.class.should eq(DeckOfCards)
			subject.players[0].number_of_cards.should eq(5)
		end
		it "should leave a pond of cards to draw from" do
			subject.deck.cards.size.should eq(32)
		end
	end
	describe "players" do
		before(:each) do
			@game = GoFishGame.new(["John", "Jay", "Ken", "Christian"])
			@game.deck.cards = []
			@game.deck.add_cards("7C 7D 7H 7S 3C 4D 5H 6S 4H 2C")
			3.times { @game.players[0].hand << @game.deck.draw }
			@game.players[1].hand << @game.deck.draw
			@game.players[0].ui = mock(GoFishCLIPlayerUI)
			@game.players[0].ui.stub!(:ask_for_input).and_return([@game.players[1], "7"])
			@game.players[0].ui.stub!(:got_books)

		end
		subject { @game.players[0] }
		context "a human player" do
			it "should decide on a card and opponent to ask when it is their turn" do
				subject.ui.should_receive(:ask_for_input).and_return([@game.players[1], "7"])

				command = subject.ui.ask_for_input
				command[0].class.should eq(GF_Player)
				command[0].should_not eq(subject)
				(/[2-9jqkaJQKA]|10/ =~ command[1]).should_not eq(nil)
			end
		end
		context "a robot player" do
			it "should algorithmically decide on a card and opponent to ask when it is their turn" do
				subject.ui = GoFishRobotPlayerUI.new(subject)
				subject.ui.class.should eq(GoFishRobotPlayerUI)
				
				command = subject.ui.ask_for_input
				command[0].class.should eq(GF_Player)
				command[0].should_not eq(subject)
				(/[2-9jqkaJQKA]|10/=~command[1]).should_not eq(nil)
				command[1].should eq("7")
			end
		end
		it "should return a card if asked for it and they have it" do
			#@game.players[1].give("7").inspect
			card = @game.players[1].give("7")
			card[0].class.should eq(Card)
			card[0].suit.should eq("S")
		end
		it "should draw from the pond if they do not receive a card" do
			card = @game.players[1].give("6")
			if card == nil then
				card = @game.deck.draw
				p card.inspect
				card.class.should eq(Card)
				card.suit.should eq("C")
			end
		end
		it "should score out a book if they end up with 4 of a kind" do
			card = @game.players[1].give("7")
			subject.hand << card[0]
			subject.ui.should_receive(:got_books).with("7")
			subject.check_for_books
			subject.books.size.should eq(1)
			subject.number_of_cards.should eq(0)
		end
		it "should pass on play to another player if their request is unsuccessful, and they do not draw the correct card." do
			@game.players[1]
			@game.players[1].add_cards("JS JC")
			@game.players[2].add_cards("QS")
			@game.players[3].add_cards("QH")
			@game.players[1].ui = GoFishRobotPlayerUI.new(@game.players[1])
			next_player = @game.players[1].take_turn
			next_player.should_not eq(@game.players[1])
		end
	end
	describe "the game" do
	before(:each) do
			@game = GoFishGame.new(["John", "Jay", "Ken", "Christian"])
			@game.deck.cards = []
			@game.deck.add_cards("7C 7D 7H 7S 3C 4D 5H 6S 4H 2C")
			3.times { @game.players[0].hand << @game.deck.draw }
			@game.players[1].hand << @game.deck.draw
			@game.players[0].ui = mock(GoFishCLIPlayerUI)
			@game.players[0].ui.stub!(:ask_for_input).and_return([@game.players[1], "7"])
			@game.players[0].ui.stub!(:got_books)
			@game.players[0].ui.stub!(:received)
			@game.players[1].ui = GoFishRobotPlayerUI.new(@game.players[1])
			@game.ui = mock(UserInterface)
			@game.ui.stub!(:game_end)
			@game.ui.stub!(:winner)
			@game.players[1].add_cards("JS JC")
			@game.players[2].add_cards("QS")
			@game.players[3].add_cards("QH")
			@game.current_player = @game.players[1]
		end
		subject {@game}

		it "should end play if the deck runs out of cards" do
			subject.deck.cards = []

			subject.ui.should_receive(:game_end).with(2)						

			until subject.end? do
				subject.current_player = subject.current_player.take_turn
			end
			
			subject.players[1].books.size.should eq(0)
			scores = subject.players.collect{|p| p.hand.size}
			subject.end?.should eq(true)
		end
		it "should end play if any player runs out of cards" do
			subject.players[3].give("Q")
			subject.ui.should_receive(:game_end).with(1)						
			
			until subject.end? do
				subject.current_player = subject.current_player.take_turn
			end
			
			subject.end?.should eq(true)
		end
		it "should display the winner(s) who have the greatest numbers of books." do
			subject.current_player = subject.players[0]
			subject.ui.should_receive(:winner)

			until subject.end? do
				subject.current_player = subject.current_player.take_turn
			end
			winner = subject.end
			winner.should eq(subject.players[0])
		end
	end
	describe "the human interface" do
		it "should ask the player for input on which card and opponent to target" do
			#@game.players[0].ui.should_receive(:ask_for_input)
		end
	end
end

		

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

		ace_spades_1.should == ace_spades_2
		ace_spades_1.should eq(ace_spades_2)
		(hash[ace_spades_2]=='WILD').should equal true
	end
end
