require_relative '../../app/models/gofish_game.rb'

FactoryGirl.define do
  factory :game, :class => GoFishGame do
    ignore do
      names ["John","Simon","Susanna","Rosie"]
    end

    initialize_with {GoFishGame.new(names)}
  end
end
