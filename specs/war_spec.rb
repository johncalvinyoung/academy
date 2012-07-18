require_relative '../deck.rb'
require_relative '../player.rb'
require_relative '../game.rb'

describe Game do
	it "should create valid cards" do
		card1 = Card.new(4, "hearts")
		card1.value.should eq(3)
	end
	it "should have a deck with the right number of cards" do
		game1 = Game.new(["John", "Caleb"])
		game1.deck.number_of_cards.should eq(52)
	end
	it "should deal cards correctly" do
		game = Game.new(["John","Caleb"])
		game.deal
		game.players[0].number_of_cards.should eq(52/game.players.size)
		game.players[0].hand.should_not eq(game.players[1].hand)
	end
	it "should score a single play correctly" do
		player1 = Player.new("Doug")
		player1.add_cards("2D")
		player1.play
		player1.score.should eq(0)
	end
	it "should score a loss correctly" do
		game = Game.new(["Ken","Caleb"])
		game.players[0].add_cards("8S 9D 10H")
		game.players[1].add_cards("8C")
		3.times do game.play_round end
		game.players[0].score.should eq(4)
		game.players[1].score.should eq(0)
	end
	it "should draw and pop" do
		game = Game.new(["Ken","Caleb"])
		game.deal
		card1 = game.players[0].hand[0]
		card2 = game.players[0].hand.shift
		card1.should eq(card2)
		card3 = game.players[0].hand << card1
		card4 = game.players[0].hand.last
		card5 = game.players[0].hand[-1]
		card4.should eq(card5)
		card1.should eq(card5)
	end
	it "should play 2-player match correctly and yield winner" do
		game = Game.new(["John","Caleb"])
		game.deal
		
		while game.scores.max < 52
			game.play_round
			if game.scores.min == 0
				game.scores.max.should eq(52)
			end
			if game.rounds >10000 then
				solve = 0
				break print(game.scores.inspect, game.rounds, "\n")
			else
				solve = 1
			end

		end
		if solve == 1 then
			game.scores.min.should eq(0)
			game.scores.uniq.size.should eq(2)

			winner = game.scores.index(game.scores.max)
			print( "Winner: ", game.players[winner].name, ". Rounds Played: ", game.rounds, "\n")
		end
	end
	it "should play with many players correctly and yield winner." do
		game = Game.new(["John", "Jay", "Josh", "Christian"])
		game.deal
		game.scores.size.should eq(4)
		game.scores.class.should eq(Array)
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
			game.scores.min.should eq(0)
			game.scores.max.should eq(52)
			game.scores.uniq.size.should eq(2)
			winner = game.scores.index(game.scores.max)
			print( "Winner: ", game.players[winner].name, ". Rounds Played: ", game.rounds, "\n")	
		end
	end


end
