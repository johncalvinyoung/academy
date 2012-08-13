# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  end


	factory :returning_user, class: User do
		name "John"
		email "test@test.com"
		password "tester"
		after(:build) do |user|
      			user.results.build(:game => GoFishGame.new(["John","Jack","Jill","Pail"]), :winner => "win", :user => user)
			user.results[0].scores.build(:player_index => 0, :value => 5, :game_result_id => user.results[0].id)
			user.build_address(:name => "John", :street => "305 E Washington St", :city => "Lexington", :state => "Virginia", :zip => "24450")
			user.address.save
		end
	end

end
