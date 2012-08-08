require 'spec_helper'

describe Score do
  subject {Score.create(:value => 1, :player_index => 1, :game_result_id => 1) }
  its(:value) {should_not be_nil}
  its(:player_index) {should_not be_nil}
end
