require 'rubygems'
require 'neography'
require 'csv'
require 'pp'
require 'ostruct'

csv_text = File.read("data/users.csv")
csv = CSV.parse(csv_text, :headers => true)

user_and_friends = Hash.new {|h,k| h[k] = [] }

csv.each do |row|
	user_id = row["user_id"].to_s
	user_and_friends[user_id] << ""
end

events_file = File.read("data/temp_events.csv")
csv = CSV.parse(events_file, :headers => false)
events = Hash.new {|h,k| h[k] = [] }

csv.each do |row|
	events[row[1].to_s] << ""
end

pp "Starting..."

event_attendees_file = File.read("data/event_attendees.csv")
csv = CSV.parse(event_attendees_file, :headers => true)

filtered_events = []
csv.each do |row|
	event_id = row["event"].to_s
	filtered_yes_ids = []
	filtered_maybe_ids = []
	filtered_invited_ids = []
	filtered_no_ids = []

	if events.has_key?(event_id)
		filtered_event = OpenStruct.new
		filtered_event.event_id = event_id

		yes_ids = row["yes"]
		maybe_ids = row["maybe"]
		invited_ids = row["invited"]
		no_ids = row["no"]

		if yes_ids != nil
			yes_ids.split(" ").each do |user_id|
				filtered_yes_ids << user_id if user_and_friends.has_key?(user_id.to_s)
			end
		end

		if maybe_ids != nil
			maybe_ids.split(" ").each do |user_id|
				filtered_maybe_ids << user_id if user_and_friends.has_key?(user_id.to_s)
			end
		end

		if invited_ids != nil
			invited_ids.split(" ").each do |user_id|
				filtered_invited_ids << user_id if user_and_friends.has_key?(user_id.to_s)
			end
		end

		if no_ids != nil
			no_ids.split(" ").each do |user_id|
				filtered_no_ids << user_id if user_and_friends.has_key?(user_id.to_s)
			end
		end

		filtered_event.yes = filtered_yes_ids.join(",")
		filtered_event.maybe = filtered_maybe_ids.join(",")
		filtered_event.invited = filtered_invited_ids.join(",")
		filtered_event.no = filtered_no_ids.join(",")

		filtered_events << filtered_event
	end
end

CSV.open("data/finished_importing_event_attendees.csv", "wb") do |csv|
	csv << ["event_id", "yes", "maybe", "invited", "no"]
	filtered_events.each do |filtered_event| 
		csv << [filtered_event.event_id, filtered_event.yes, filtered_event.maybe, filtered_event.invited, filtered_event.no]
	end
end

pp "Done.."