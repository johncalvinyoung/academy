require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the GameHelper. For example:
#
# describe GameHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe GameHelper do
	it "should retrieve messages from a game in progress" do
		@user = FactoryGirl.create(:returning_user)
		@game_result = @user.results.first
		@game = @user.results.first.game
		@game.deal
		@game.start
		@player = @game.players.first
		@player.mygame = @game
		@player.decision = [@game.players[2], @player.hand.first.rank]
		@player.take_turn
		dequeue_messages.should_not be_nil
	end
end
