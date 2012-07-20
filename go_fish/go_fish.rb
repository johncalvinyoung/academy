require 'sinatra'
require 'haml'
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

  def self.games
    @@games
  end

  set :haml, :format => :html5

  get '/' do
    haml :index
  end

  get '/game/:id' do
    if @@games[params[:id]].class != GoFishGame then redirect '/' end
      @game = @@games[params[:id]]
      if @game.current_player == @game.players[0] then
	@turn = true
	haml :game, :format => :html5

      else
	@game.current_player.decision = robot_decision(@game.current_player)
	@game.current_player = @game.current_player.take_turn
	if @game.end? then
	  redirect '/end/'+@params[:id]
	else
	  @turn = false
	  haml :game
	end
      end
  end
  
  post '/game' do
    key = ('a'..'z').to_a.shuffle[0,8].join
    @@games[key] = GoFishGame.new([@params["player_name"], "Ken", "Jay", "Christian"])
    @game = @@games[key]
    @game.key = key
    @game.deal
    @game.start
    redirect '/game/'+key
  end

  post '/play' do
    @game = @@games[@params['key']]
    if @params['opponent'] == nil || @params['rank'] == nil then redirect '/turn/'+@params['key'] end
    o_id = Integer(@params['opponent'])
    opponent = @game.players[o_id]
    rank = @params['rank']
    @game.players[0].decision = [opponent, rank]
    @game.current_player = @game.current_player.take_turn
    if @game.end? then
      redirect '/end/'+@params['key']
    else
      redirect '/game/'+@params['key']
    end
  end

  get '/turn/:id' do
    @game = @@games[@params[:id]]
    haml :turn
  end

  get '/end/:id' do
    @game = @@games[@params[:id]]
    @winner = @game.score
    haml :end
  end

  def robot_decision(player)
    top_rank = player.search_for_top_rank
    opponents = player.opponents.shuffle!
    return [opponents[0], top_rank]
  end

  run! if app_file == $0
end
