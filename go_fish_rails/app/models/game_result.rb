class GameValidator < ActiveModel::Validator
  def validate(record)
    if record.game.class != GoFishGame
      record.errors[:base] << "The game cannot be found, or is malformed."
    end
  end
end

class GameResult < ActiveRecord::Base
  belongs_to :user
  has_many :scores
  attr_accessible :game, :userid, :user, :winner

  validates_with GameValidator, :on => :update
  #validates :winner, :presence => true, :if "self.scores != []"
  
  serialize :game

  def save_state id
    record = GameResult.find(id)
    p record
    record.game = @game
    return record.handle
  end

  def retrieve_state id
    result = GameResult.find(id)
    return result.game
  end

  def unique_id
    return ('a'..'z').to_a.shuffle[0,8].join
  end

end
