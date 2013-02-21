require 'rubygems'
require 'neography'
require 'csv'
require 'pp'
require File.expand_path('../../server', __FILE__)

csv_text = File.read("data/finished_importing.csv")
csv = CSV.parse(csv_text, :headers => true)
user_finder = UserFinder.new
pp "Starting..."
csv.each do |row|
	user = row["user_id"].to_s
	friends = row["friend_ids"].split(",")
	
	if !friends.empty?
		user_node = user_finder.find_by_id(user)
		if user_node
			friends.each do |friend|
				friend_node = user_finder.find_by_id(friend.to_s)
				if friend_node
					$neo.create_relationship("friend_with", user_node, friend_node)
					pp "#{user_node["self"]} is friended with #{friend_node["self"]}" 
				end
			end
		end
	end
end

pp "Done.."

