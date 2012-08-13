# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    name "Me"
    street "101 MyStreet"
    city "MyCity"
    state "NC"
    zip "10101"
    user_id 1
  end
end
