require 'rubygems'
require 'neography'

@neo = Neography::Rest.new("http://127.0.0.1:7476")

def create_graph
	root = @neo.get_root

	users = @neo.create_node("name" => "Users")
	@neo.create_relationship("contains", root, users)

	events = @neo.create_node("name" => "Events")
	@neo.create_relationship("contains", root, events)

	users_index = @neo.create_node_index("users_index")
	@neo.add_node_to_index("users_index", "name", "users_index", users)

	events_index = @neo.create_node_index("events_index")
	@neo.add_node_to_index("events_index", "name", "events_index", events)
end

create_graph
