class UserInterface
     attr_reader :game
	  def start(players)
	       init_players = ["Caleb", "Christian","Jay","Ken","John", "Doug"]
	       @game = GoFishGame.new(init_players.slice(0..players-1))
	       @game.ui = self
	       @game.players.each {|player| GoFishRobotPlayerUI.new(player)}
	       @game.deal
	       @game.start
	       GoFishCLIPlayerUI.new(@game.current_player)
	  end
end
