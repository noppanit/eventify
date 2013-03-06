require File.expand_path('../spec_helper', __FILE__)

describe "User finder" do
	it "should get me the user" do
		user_finder = UserFinder.new
		user = user_finder.find_by_id("224360826")
		user.should_not eql nil
	end

	it "should not get me the user" do
		user_finder = UserFinder.new
		user = user_finder.find_by_id("1")
		user.should eql nil
	end

	it "should not get me the users" do
		user_finder = UserFinder.new
		users = user_finder.find_by_ids(["644370022", "2336501033"])
		users.should_not eql nil
	end

	it "should not all the people who have friends" do
		user_finder = UserFinder.new
		users = user_finder.get_friends
	end

	it "should get events I should go" do
		user_finder = UserFinder.new
		users = user_finder.get_event_i_should_go	
		users.should_not eql nil
	end

end