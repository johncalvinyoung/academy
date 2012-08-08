# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    name "MyString"
    street "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    user_id 1
  end
end
