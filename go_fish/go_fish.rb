require 'sinatra'
require 'haml'
require 'yaml'
require 'json'
require 'mongo'

require_relative '../deck.rb'
require_relative '../player.rb'
require_relative '../game.rb'
require_relative '../block.rb'
require_relative '../gofish_player.rb'
require_relative '../gofish_game.rb'
require_relative '../user_interface.rb'
require_relative '../playerui.rb'


class GoFishApp < Sinatra::Base
  def initialize
    super
    @@games ||= Hash.new
  end

  configure do
    conn = Mongo::Connection.new("localhost", 27017)
    set :mongo_connection, conn
    set :mongo_db,         conn.db('go_fish')
  end

  def self.games
    @@games
  end

  set :haml, :format => :html5

  get '/' do
    haml :index
  end

  get '/game/:id' do
    #if @@games[params[:id]].class != GoFishGame then redirect '/' end
    #@game = @@games[params[:id]]
    @game = retrieve(params[:id])
      if @game.current_player == @game.players[0] then
	@turn = true
	haml :game, :format => :html5
      else
	@game.current_player.decision = robot_decision(@game.current_player)
	@game.current_player = @game.current_player.take_turn
	@messages = @game.messages
	#@game.clear_messages
	save(@game)
	if @game.end? then
	  redirect '/end/'+@params[:id]
	else
	  @turn = false
	  haml :game
	end
      end
  end
  
  post '/game' do
    key = unique_id
    @game = GoFishGame.new([@params["player_name"], "Ken", "Jay", "Christian"])
    #@@games[key] = @game
    @game.key = key
    @game.deal
    @game.start
    save(@game)
    redirect '/game/'+key
  end

  post '/play' do
    @game = retrieve(params['key'])
    #if @params['opponent'] == nil || @params['rank'] == nil then redirect '/turn/'+@params['key'] end
    o_id = Integer(@params['opponent'])
    opponent = @game.players[o_id]
    rank = @params['rank']
    @game.players[0].decision = [opponent, rank]
    @game.current_player = @game.current_player.take_turn
    save(@game)
    if @game.end? then
      redirect '/end/'+@params['key']
    else
      redirect '/game/'+@params['key']
    end
  end

  post '/player' do
    @player = find_player(params["player_name"])
    if(@player == nil) then
     @player = create_player(params["player_name"])
     p @player.is_a?Hash
     haml :welcome_new_player
    else
     haml :welcome_back
    end
  end

  get '/player/:name' do
    @player = find_player(params[:name])
    haml :view_player
  end

  get '/end/:id' do
    @game = retrieve(params[:id])
    @winner = @game.score
    @player = @game.players[0]
    update_player_stats(@player)

    #File.open('players', 'r') do |file|
    #  @players = JSON.parse file.read
    #end
    #@won = (@player == @winner)
    #@players[@player.name]["games"] << [@player.books.size,@won]
    #File.open('players', 'w') do |file|
    #  file.write(@players.to_json)
    #end
    haml :end
  end

  get '/retrievegame/:id' do
    @game = retrieve(params[:id])
    p @game.current_player.name
  end

  helpers do
    def dequeue_messages
      message = @game.messages
      @game.clear_messages
      save(@game)
      return message
    end
  end

  def robot_decision(player)
    top_rank = player.search_for_top_rank
    opponents = player.opponents.shuffle!
    return [opponents[0], top_rank]
  end

  def unique_id
    return ('a'..'z').to_a.shuffle[0,8].join
  end

  def save(game)
    File.open("games/"+game.key, 'w') do |file|
      file.write(game.to_yaml)
    end

    File.open("games/"+game.key+".json", 'w') do |file|
      file.write(game.to_json)
    end
  end

  def retrieve(game_id)
    File.open("games/"+game_id+".json", 'r') do |file|
      @retrieved = GoFishGame.from_json file.read
    end
    p @retrieved.players

    File.open("games/"+game_id, 'r') do |file|
      YAML::load(file)
    end
  end

  def find_player(name)
    db = settings.mongo_db["player_records"]
    record = db.find("name" => name).to_a[0]
    if record != nil then
      return record
    else
      return nil
    end
  end

  def create_player(name)
    @player = {"name" => name, "games" => []}
    db = settings.mongo_db["player_records"]
    id = db.insert(@player)
    return @player
  end

  def update_player_stats(player)
    report = [@player.books.size, (@player == @winner)]
    db = settings.mongo_db["player_records"]
    record = db.find("name" => @player.name).to_a[0]
    record["games"] << report
    db.update({"name" => @player.name}, record)
  end

  run! if app_file == $0
end
