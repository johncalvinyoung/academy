class Address < ActiveRecord::Base
  attr_accessible :city, :name, :state, :street, :user_id, :zip
  belongs_to :user
  validates :name, :presence => true
  validates :street, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
end
