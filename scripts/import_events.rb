require 'rubygems'
require 'neography'
require 'csv'
require 'pp'

# @neo = Neography::Rest.new("http://127.0.0.1:7476")
# users_index = @neo.get_node_index("users_index", "name", "users_index")[0]

csv_text = File.read("data/temp_events.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
	pp row 

	break
	
end

