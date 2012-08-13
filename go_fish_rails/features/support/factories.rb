require 'factory_girl'

FactoryGirl.define do
	factory :returning_player, class: User do
		name "John"
		email "test@test.com"
		password "tester"
		after(:build) do |user|
      			user.results.build(:game => GoFishGame.new(["John","Jack","Jill","Pail"]), :winner => "win", :user => user)
			user.results[0].scores.build(:player_index => 0, :value => 5, :game_result_id => user.results[0].id)
			user.build_address(:name => "John", :street => "305 E Washington St", :city => "Lexington", :state => "Virginia", :zip => "24450")
			user.address.save
		end
	end

	factory :win, class: GoFishGame do
    		ignore do
      			names ["John","Simon","Susanna","Rosie"]
    		end

    		initialize_with {GoFishGame.new(names)}
		after(:build) do |game|
			game.deck = []
			game.players[0].books << Book.new("A")
		end
	end

	factory :loss, class: GoFishGame do
    		ignore do
      			names ["John","Simon","Susanna","Rosie"]
    		end

    		initialize_with {GoFishGame.new(names)}
		after(:build) do |game|
			game.players[0].books << Book.new("A")
			game.players[1].books << Book.new("K")
			game.players[1].books << Book.new("J")
			game.players[1].hand = []
		end
	end

	factory :tie, class: GoFishGame do
    		ignore do
      			names ["John","Simon","Susanna","Rosie"]
    		end

    		initialize_with {GoFishGame.new(names)}
		after(:build) do |game|
			game.players[0].books << Book.new("A")
			game.players[1].books << Book.new("K")
			game.deck.cards = []
		end
	end

end
