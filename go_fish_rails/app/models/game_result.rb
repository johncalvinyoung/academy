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
  attr_accessible :game, :userid, :user, :winner#, :ulist

  validates_with GameValidator, :on => :update
  #validates :winner, :presence => true, :if "self.scores != []"
  
  serialize :game
	#serialize :ulist

  def unique_id
    return ('a'..'z').to_a.shuffle[0,8].join
  end

end
