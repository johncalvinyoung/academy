require 'spec_helper'

describe Address do
	it "should not be nil" do
		@address = FactoryGirl.create(:address)
		@address.street.should_not be_nil
	  @address.city.should_not be_nil
		@address.state.length.should eq(2)
		@address.zip.should_not be_nil
		@address.name.should eq("Me")
		@address.user_id.should_not be_nil
	end	
end
