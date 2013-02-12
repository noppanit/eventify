require 'rubygems'
require 'neography'
require 'csv'
require 'pp'

@neo = Neography::Rest.new("http://127.0.0.1:7476")
users_index = @neo.get_node_index("users_index", "name", "users_index")[0]

csv_text = File.read("data/users.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
	user_id = row["user_id"]
	locale = row["locale"]
	birthyear = row["birthyear"]
	gender = row["gender"]
	joinedAt = row["joinedAt"]
	location = row["location"]
	timezone = row["timezone"]

	user = @neo.create_node("user_id" => user_id,
		"locale" => locale,
		"birthyear" => birthyear,
		"gender" => gender,
		"joinedAt" => joinedAt,
		"location" => location,
		"timezone" => timezone)

	@neo.create_relationship("has_user", users_index, user)

	pp user_id
end

