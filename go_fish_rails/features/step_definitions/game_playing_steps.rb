When /^a new user$/ do
end

When /^he signs up$/ do
	visit '/'
	within(:css, "#register_form") do
		fill_in 'user[name]', :with => 'Christian'
		fill_in 'user[password]', :with => 'tester'
		fill_in 'user[email]', :with => 'rcdilorenzo@me.com'
		fill_in 'user[password_confirmation]', :with => 'tester'
		click_on 'Register'
	end
	@user = User.find_by_name('Christian')
end

And /^he enters his address information$/ do
	fill_in 'address_street', :with => '305 E Washington St'
	fill_in 'address_city', :with => 'Lexington'
	fill_in 'address_state', :with => 'Virginia'
	fill_in 'address_zip', :with => '24450'
	click_on 'Update User'
	nil
end

Then /^he can start a new game$/ do
	#find('#banner').value.should have_content("Christian")
	page.should have_content('Welcome')
	page.should have_button('Start')
end

When /^he starts a game$/ do
	click_on 'Start'
end

Then /^he sees a new game with his name at the bottom$/ do
	page.should have_content('Deck: 32')
	find('#player0 .name').should have_content(@user.name)
end


Given /^a returning user$/ do
	@user = FactoryGirl.create(:returning_player)
end

When /^he logs in$/ do
	visit '/'
	within(:css, "#login_form") do
		fill_in 'user[email]', :with => 'test@test.com'
		fill_in 'user[password]', :with => 'tester'
		click_on 'Log In'
	end
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

And /^another user exists$/ do
	@user2 = FactoryGirl.create(:returning_player, "email" => 'example@example.com')
end

When /^you view the user list$/ do
	visit '/players'
end

Then /^you can see their stats$/ do
	page.should have_content('User List')
	page.should have_content('John')
	page.should have_content('5')
end

Given /^the user is logged in$/ do
	@user = FactoryGirl.create(:returning_player)
	visit '/'
	within(:css, "#login_form") do
		fill_in 'user[password]', :with => 'tester'
		fill_in 'user[email]', :with => @user.email
		click_on 'Log In'
	end
end

And /^a winning game$/ do
	@game = FactoryGirl.build(:win)
	@user.results.first.update_attributes({:game => @game})
	#@user.results.build(:game => @game)
	@user.save
	#@user.results[1].save
end

When /^you view the end page$/ do
	visit '/game/'+@user.results[0].id.to_s+'/end'
end

Then /^the user is listed as winner$/ do
	page.should have_content('John has 1 book')
end

And /^a losing game$/ do
	@game = FactoryGirl.build(:loss)
	@user.results.first.update_attributes({:game => @game})
	@user.save
	#@user.results[1].save
end

Then /^a robot is listed as winner$/ do
	page.should have_content('Simon has 2 books')
end

And /^a tied game$/ do
	@game = FactoryGirl.build(:tie)
	@user.results.first.update_attributes({:game => @game})
	@user.save
end

Then /^both tied players are listed as winners$/ do
	page.should have_content('John, Simon, each had 1 books')
end

And /^he is on his dashboard$/ do
	visit '/play'
end

Then /^when he edits his profile$/ do
	click_on 'Edit Profile'
end

Then /^he can see his address$/ do
	find('#address_street').value.should eq('305 E Washington St')
end

When /^you click the title$/ do
	click_on 'Go Fish Game'
end

Then /^you can see a tie in your stats$/ do
	page.should have_content('0015')
end
