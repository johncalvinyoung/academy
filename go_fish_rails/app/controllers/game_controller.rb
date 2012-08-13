class GameController < ApplicationController

	before_filter :authenticate_user!

  def display
    @game_result = GameResult.find(params[:id])
    @game = @game_result.game
    @game.players.each{|player| player.mygame = @game}
    if @game.current_player == @game.players[0] then  
      @turn = true
      render :game
    else
      top_rank = @game.current_player.search_for_top_rank
      opponents = @game.current_player.opponents.shuffle!
      @game.current_player.decision = [opponents[0], top_rank]
      @game.current_player = @game.current_player.take_turn
      if @game.end? then
	@game_result.save
	redirect_to end_url(params[:id])
      else
	@turn = false
	render :game
      end
    end
  end


  def new
    #@user = User.find_or_create_by_name(params["player_name"])
		@user = current_user
    @game_result = @user.results.build(:game => GoFishGame.new([@user.name,"Susanna","Beth","Richard"]))
    @game = @game_result.game
    @game.deal
    @game.start
    @user.save!
    @game_result.save!
    redirect_to game_url(@game_result.id)
  end

  def play
    @game_result = GameResult.find(params['id'])
    @game = @game_result.game
    @game.players.each{|player| player.mygame = @game}    
    o_id = Integer(params['opponent'])
    opponent = @game.players[o_id]
    rank = params['rank']
    @game.players[0].decision = [opponent, rank]
    @game.current_player = @game.current_player.take_turn
    @game_result.save
    if @game.end? then
      redirect_to end_url(params[:id])
    else
      redirect_to game_url(params[:id])
    end
  end

  def endgame
    @game_result = GameResult.find(params['id'])
    @game = @game_result.game
    @winner = @game.score
    @player = @game.players[0]
    @game.players.each_index {|player_index|
      @game_result.scores.build(:player_index => player_index, :value => @game.players[player_index].books.size)
    }
    if @winner == @player then
      @game_result.winner = "win"
    elsif @winner.class == Array && @winner.include?(@player) then
      @game_result.winner = "tie"
    else
      @game_result.winner = "loss"
    end
    @game_result.save
    render :end
  end

  #controller helpers
  
  def robot_decision(player)
    top_rank = player.search_for_top_rank
    opponents = player.opponents.shuffle!
    return [opponents[0], top_rank]
  end

end
