require 'rubygems'
require 'neography'
require 'csv'
require 'pp'
require File.expand_path('../../server', __FILE__)

csv_text = File.read("data/finished_importing_event_attendees.csv")
csv = CSV.parse(csv_text, :headers => true)
user_finder = UserFinder.new
event_finder = EventFinder.new

pp "Starting..."

csv.each do |row|
	
	event_id = row["event_id"].to_s
	yes = row["yes"]
	maybe = row["maybe"]
	invited = row["invited"]
	no = row["no"]
	
	event_node = event_finder.find_by_id(event_id)	

	if yes != "" or yes != nil
		yes.split(",").each{ |id|
			user_node = user_finder.find_by_id(id)
			if user_node != nil
				$neo.create_relationship("yes", user_node, event_node)
				pp "#{user_node["self"]} yes to #{event_node["self"]}" 
			end
		}
	end

	if maybe != "" or maybe != nil
		maybe.split(",").each{ |id|
			user_node = user_finder.find_by_id(id)
			if user_node != nil
				$neo.create_relationship("maybe", user_node, event_node)
				pp "#{user_node["self"]} maybe to #{event_node["self"]}" 
			end
		}
	end

	if invited != "" or invited != nil
		invited.split(",").each{ |id|
			user_node = user_finder.find_by_id(id)
			if user_node != nil
				$neo.create_relationship("invited", user_node, event_node)
				pp "#{user_node["self"]} invited to #{event_node["self"]}" 
			end
		}
	end

	if no != "" or no != nil
		no.split(",").each{ |id|
			user_node = user_finder.find_by_id(id)
			if user_node != nil
				$neo.create_relationship("no", user_node, event_node)
				pp "#{user_node["self"]} no to #{event_node["self"]}" 
			end
		}
	end

	
end

pp "Done.."

