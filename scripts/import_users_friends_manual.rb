require 'rubygems'
require 'neography'
require 'csv'
require 'pp'

csv_text = File.read("data/users.csv")
csv = CSV.parse(csv_text, :headers => true)

user_and_friends = Hash.new {|h,k| h[k] = [] }

csv.each do |row|
	user_id = row["user_id"].to_s
	
	user_and_friends[user_id] << ""
	pp user_id
end

pp "Starting..."

csv_text = File.read("data/kaggle_user_friends.csv")
csv = CSV.parse(csv_text, :headers => true)

csv.each do |row|
	user = row["user"].to_s
	friends = row["friends"].split(",")
	
	friends.each do |friend_id|
		if user_and_friends.has_key?(friend_id.to_s)
			user_and_friends[user] << friend_id.to_s
		end
	end	

	pp user
end

CSV.open("data/finished_importing.csv", "wb") do |csv|
	csv << ["user_id", "friend_ids"]
	user_and_friends.each do |key,value| 
		csv << [key, value.reject! { |c| c.empty? }.join(",")]
	end
end

pp "Done.."



