require 'sinatra'
require 'haml'
require 'rspec'
require 'rack/test'
require_relative '../go_fish/go_fish.rb'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe GoFishApp do
  include Rack::Test::Methods

  set :environment, :test

  before(:each) do
  end

  def app
    GoFishApp
  end
  it "should display a home page" do
    get '/'
    last_response.should be_ok
    last_response.status.should == 200
    last_response.body =~/<html>.*Name.*<\/html>/im
  end
  it "should create a new game if player submits name" do
    app = Rack::Test::Session.new(Rack::MockSession.new(GoFishApp))
    post '/game', :player_name => 'Jack'
    last_response.should be_redirect
    follow_redirect!
    #need to pass in a name to correctly create game
    last_response.body.should =~ /<div class='name'>.*Jack.*<\/div>/im
    #p GoFishApp.games.first[1].players[0].name
  end
  it "should load a game if player has an id" do
    key = GoFishApp.games.first[0]  
    get '/game/'+key
    last_response.should be_ok
    last_response.body.should =~ /<div id='table'>/i
  end
  it "should display the human player's hand" do
    key = GoFishApp.games.first[0]  
    get '/game/'+key
    last_response.should be_ok
    last_response.body.should =~ /<div id='player0'>.*<div class='hand'>.*\S*\s\S*\s\S*\s\S*\s\S*.*<\/div>/im
  end

  it "should ask the player for input when it is his turn" do
    key = GoFishApp.games.first[0]
    game = GoFishApp.games[key]
    game.current_player = game.players[0]
    get '/game/'+key
    last_response.body.should =~ /your turn to play/im
  end

  it "should accept input from the player, and show him the results on the next page-load" do
    app = Rack::Test::Session.new(Rack::MockSession.new(GoFishApp))
    key = GoFishApp.games.first[0]
    game = GoFishApp.games[key]
    post '/play', {:key => key, :opponent => "2", :rank => game.players[0].hand.sample.rank}
    last_response.should be_redirect
    follow_redirect!
    last_response.body.should =~ /<div id='messages'>.*asked Jay for/im
  end

  it "should end the game if the deck is empty, and display the winner." do
    key = GoFishApp.games.first[0]
    game = GoFishApp.games[key]
    game.deck.cards = []
    game.current_player = game.players[1]
    get '/game/'+key
    last_response.should be_redirect
    follow_redirect!
    last_response.body.should =~ /Game Over/im
  end
end
