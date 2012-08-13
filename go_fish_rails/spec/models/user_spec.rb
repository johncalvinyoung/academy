require 'spec_helper'

describe User do
	it "should have an address" do
		@user = FactoryGirl.create(:returning_user)
		@user.address.should_not be_nil
	end


	
end
