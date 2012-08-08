require 'spec_helper'

describe GameResult do
  subject {GameResult.create(:user => User.new(:name => 'John'), :game => GoFishGame.new(["J","K","L","M"]))}
  its(:user) {should_not be_nil}
  its(:game) {should be_a_kind_of GoFishGame}

  it "should reject saving a non-game to the game field" do
    subject.game = "poodle"
    subject.save

    subject.errors[:base].should_not be_nil
  end



  it "should save a game to the database, then return it when asked" do
    @game = GoFishGame.new(["John","Jay","Arthur","Sheldon"])
    @game.deal
    @game.start
    key = unique_id
    
    @game_result = GameResult.create
    @game_result.save_state @game_result.id
    retrieved_game = @game_result.retrieve_state @game_result.id
    assert_equal(retrieved_game, @game)
  end


    def unique_id
    return ('a'..'z').to_a.shuffle[0,8].join
    end


end
