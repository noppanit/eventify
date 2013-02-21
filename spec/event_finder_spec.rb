require File.expand_path('../spec_helper', __FILE__)

describe "User finder" do
	it "should get me the event" do
		event_finder = EventFinder.new
		event = event_finder.find_by_id("3878729950")
		event.should_not eql nil
	end

	it "should not get me the event" do
		event_finder = EventFinder.new
		event = event_finder.find_by_id("38787")
		event.should eql nil
	end

end