require 'bcrypt'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :address, :username, :token, :token_expires_at
  has_many :results, :class_name => 'GameResult'
  has_one :address
  validates :name, :presence => true
  validates :username, :uniqueness => true
  
  def games
    results.map(&:game)
  end


  def count_games
	results.select{|game| game.winner != nil}.size
  end

  def count_wins
	results.select{|g| g.winner == "win"}.size
  end

  def count_losses
	results.select{|game| game.winner == "loss"}.size
  end

  def count_ties
	results.select{|game| game.winner == "tie"}.size
  end

  def high_score
	scores = []
	results.each{ |result|
		result.scores.each{|score|
			if score.player_index==0 then
			scores << score.value end
		}
	}
	return scores.max
  end

  def percentage_wins
	games = count_games
	wins = count_wins
	return wins.fdiv(games)*100
  end

  def password
      @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
	  @password = BCrypt::Password.create(new_password)
	  self.password_hash = @password
  end

end
