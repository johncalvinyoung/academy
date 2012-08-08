class Score < ActiveRecord::Base
  belongs_to :game_result
  attr_accessible :game_result_id, :player_index, :value, :game_result
  validates :value, :presence => true
end
