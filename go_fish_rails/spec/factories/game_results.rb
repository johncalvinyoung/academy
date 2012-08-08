FactoryGirl.define do
  factory :game_result do
    user

    after(:build) do |result|
      result.game = GoFishGame.new([result.user.name,"Jack","Jill","Pail"])
    end
  end
end
