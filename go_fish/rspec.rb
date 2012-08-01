require 'sinatra'
require 'haml'
require 'rspec'
require 'rack/test'
require 'yaml'
require 'debugger'
require_relative '../go_fish/go_fish.rb'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe GoFishApp do
  include Rack::Test::Methods

  set :environment, :test

  #before(:each) do
  #  @myapp = app.new!
  #  #app = Rack::Test::Session.new(Rack::MockSession.new(GoFishApp))    
  #  key = @myapp.unique_id
  #  @game = GoFishGame.new(["John", "Ken", "Jay", "Christian"])
  #  @game.key = key
  #  @game.deal
  #  @game.start
  #  @myapp.save(@game)
  #end

  after(:each) do
    #File.delete(@game.key)
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


  it "should save a newly created game properly" do
    @game = GoFishGame.new(["John", "Ken", "Jay", "Christian"])
    myapp = app.new!
    key = myapp.unique_id
    @game.key = key
    myapp.save(@game)
    @game = nil
    @game = myapp.retrieve(key)
    @game.players[0].name.should == "John"
  end

  it "should present a players status page when new player is identified" do
    post '/player', {name: 'Joe'}
    last_response.should be_redirect
    follow_redirect!
    last_response.body.should =~ /Welcome, Joe/im
    # able to create a new game for Joe to play
  end

  it "should present a players status page when existing player is identified" do
    post '/player/new', {name: 'Jonathan'}
    
    #verify accurate statistics are on the page
    #verify he can create a new game from here

  end

  it "should create a new game if player submits name" do
    post '/game', {:player_name => 'Jack'}
    last_response.should be_redirect
    follow_redirect!
    last_response.body.should =~ /<div class='name'>.*Jack.*<\/div>/im
  end
  it "should load a game if player has an id" do
    get '/game/irodaysx'
    last_response.should be_ok
    last_response.body.should =~ /<div id='table'>/i
  end
  it "should display the human player's hand" do
    key = 'irodaysx' 
    #key = @key
    get '/game/'+key
    last_response.should be_ok
    last_response.body.should =~ /<div id='player0'>.*<div class='hand'>.*\S*\s\S*\s\S*\s\S*\s\S*.*<\/div>/im
  end

  it "should ask the player for input when it is his turn" do
    game = @game
    game.current_player = game.players[0]
    get '/game/'+game.key
    last_response.body.should =~ /your turn to play/im
  end

  it "should accept input from the player, and show him the results on the next page-load" do
    @myapp = app.new!
    key = @myapp.unique_id
    @game = GoFishGame.new(["John", "Ken", "Jay", "Christian"])
    @game.key = key
    @game.deal
    @game.start
    @myapp.save(@game)
    @game.current_player = @game.players[0]
    post '/play', {:key => @game.key, :opponent => "2", :rank => @game.players[0].hand.sample.rank}
    last_response.should be_redirect
    follow_redirect!
    last_response.body.should =~ /<div id='messages'>.*asked Jay for/im
  end

  it "should end the game if the deck is empty, and display the winner." do
    @game.deck.cards = []
    @game.current_player = @game.players[1]
    get '/game/'+@game.key
    last_response.body.should =~ /Game Over/im
  end
end
