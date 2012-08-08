require 'spec_helper'

require 'yaml'

require 'deck'
require 'player'
require 'game'
require 'block'
require 'gofish_player'
require 'gofish_game'
require 'game_result'
require 'user'

describe User do
  subject {FactoryGirl.build(:user)}
  its(:name) {should_not be_nil}
  its(:games) {should_not be_nil}

  context 'with existing games' do
    let (:game1) {
      game = FactoryGirl.build(:game)}
    before(:each) do
      subject.results.build(:game => game1)
    end

    its(:games) {should_not be_empty}
    its(:games) {should include game1}
    specify {game1.players.first.name.should == subject.name}
  end













  describe "setup" do
    subject do
	@game = GoFishGame.new(["John", "Jay", "Ken", "Christian"])
	@game.deal
    	@game.start
	@game_result = GameResult.new
	@user = User.new
	@game
    end
    it "should create players" do
	  subject.players[0].class.should eq(GF_Player)
	  subject.players.select{|p| p.class==GF_Player}.size.should eq(4)
    end
    it "should create a deck and deal it out" do
	subject.deck.class.should eq(DeckOfCards)
	subject.players[0].number_of_cards.should eq(5)
    end
    it "should leave a pond of cards to draw from" do
	subject.deck.cards.size.should eq(32)
    end

    
  end
end
