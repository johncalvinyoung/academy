class GameController < ApplicationController

	before_filter :authenticate_user!

  def display
    @game_result = GameResult.find(params[:id])
    @game = @game_result.game
    @game.players.each{|player| player.mygame = @game}
		#current_index = @game_result.users.find_index(current_user)

    #if @game.current_player == @game.players[current_index] then 
		if @game.current_player == @game.players[0] then 
      @turn = true
      render :game
    else
			#if current_index == 0 && @game_result.users[current_index] == "Robot" then
      	top_rank = @game.current_player.search_for_top_rank
      	opponents = @game.current_player.opponents.shuffle!
      	@game.current_player.decision = [opponents[0], top_rank]
      	@game.current_player = @game.current_player.take_turn
			#end
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
		#
		#@game_result.ulist = [@user, "Robot", "Robot", "Robot"]
		#
    @game = @game_result.game
    @game.deal
    @game.start
    @user.save!
    @game_result.save!
    redirect_to game_url(@game_result.id)
  end

	def multi
		@user = current_user
		@user2 = User.find(7)
    @game_result = @user.results.build(:game => GoFishGame.new([@user.name,@user2.name,"Beth","Richard"]))
		#
		@user.save!
		@game_result.save!
		@game_result.ulist = [@user, @user2, "Robot", "Robot"]
    #
		@game = @game_result.game
    @game.deal
    @game.start
    @user.save!
    @game_result.save!
    redirect_to game_url(@game_result.id)
	end

  def play
		#retrieves primary player's gameresult and reconstitutes it.
    @game_result = GameResult.find(params['id'])
    @game = @game_result.game
    @game.players.each{|player| player.mygame = @game} 
 		#now, processing the post		
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
