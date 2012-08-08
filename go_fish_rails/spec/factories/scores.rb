# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score do
    value 1
    player_index 1
    game_result_id 1
  end
end
