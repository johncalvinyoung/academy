require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'game.rb'
require_relative 'block.rb'
require_relative 'gofish_player.rb'
require_relative 'gofish_game.rb'
require_relative 'user_interface.rb'
require_relative 'playerui.rb'

     @ui = UserInterface.new
     @ui.start(4)
     @ui.game.play

