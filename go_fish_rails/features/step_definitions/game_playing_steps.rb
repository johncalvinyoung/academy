When /^a new user$/ do
end

When /^he signs up$/ do
	visit '/'
	fill_in 'player_name', :with => 'Christian'
	click_on 'Start Game'
	fill_in 'address_street', :with => '305 E Washington St'
	fill_in 'address_city', :with => 'Lexington'
	fill_in 'address_state', :with => 'Virginia'
	fill_in 'address_zip', :with => '24450'
	click_on 'Update User'
	@user = FactoryGirl.create(:user, :name => 'Christian')
end

Then /^he can start a new game$/ do
	find('#player_name').value.should eq("Christian")
	page.should have_button('Start Game')
end

When /^he starts a game$/ do
	click_on 'Start Game'
end

Then /^he sees a new game with his name at the bottom$/ do
	page.should have_content('Deck: 32')
	find('#player0 .name').should have_content(@user.name)
end


Given /^a returning user$/ do
	@user = FactoryGirl.create(:returning_player)
end

When /^he enters his name$/ do
	visit '/'
	fill_in 'player_name', :with => 'John'
	click_on 'Start Game'
end

Then /^he sees his past stats$/ do
	page.should have_content('Full Stats')
	page.should have_content('5')
end

When /^you view his profile page$/ do
	visit '/player/'+@user.id.to_s
end

Then /^you see his past stats$/ do
	page.should have_content('Full Stats')
	page.should have_content('5')
end

Then /^you cannot start a new game$/ do
	page.should_not have_button('Start Game')
end

Given /^two returning users$/ do
	@user1 = FactoryGirl.create(:returning_player)
	@user2 = FactoryGirl.create(:returning_player)
end

When /^you view the user list$/ do
	visit '/players'
end

Then /^you can see their stats$/ do
	page.should have_content('User List')
	page.should have_content('John')
	page.should have_content('5')
end

Given /^a winning game$/ do
	@game = FactoryGirl.build(:win)
	@user = FactoryGirl.create(:returning_player)
	@user.results[0].update_attributes({:game => @game})
	#@user.results.build(:game => @game)
	@user.save
	#@user.results[1].save
end

When /^you view the end page$/ do
	visit '/game/end/'+@user.results[0].id.to_s
end

Then /^the user is listed as winner$/ do
	page.should have_content('John has 1 book')
end

Given /^a losing game$/ do
	@game = FactoryGirl.build(:loss)
	@user = FactoryGirl.create(:returning_player)
	@user.results[0].update_attributes({:game => @game})
	@user.save
	#@user.results[1].save

end

Then /^a robot is listed as winner$/ do
	page.should have_content('Simon has 2 books')
end


