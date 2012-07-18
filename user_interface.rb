class UserInterface
     attr_reader :game
	  def start(players)
	       init_players = ["Caleb", "Christian","Jay","Ken","John", "Doug"]
	       @game = GoFishGame.new(init_players.slice(0..players-1))
	       @game.ui = self
#	       @game.players.each {|player| GoFishRobotPlayerUI.new(player)}
	       @game.deal
	       @game.start
#	       GoFishCLIPlayerUI.new(@game.current_player)
	  end

	  def winner(who)
	       if who.class == Array then
		    print("There was a tie.\n")
		    who.each{|p| print(p.name,", ")}
		    print("each had ", who[0].books.size, " books.\n")
	       else
		    print("Winner: ", who.name, " has ", who.books.size, " books.\n")
	       end
	  end

	  def game_end(code)
	       if code == 1 then
		    print("Game over: a player ran out of cards.\n")
	       else
		    print("Game over: the deck ran out of cards.\n")
	       end
	  end
end
