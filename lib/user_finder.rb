class UserFinder
	def find_by_id(user_id)
		query = "START users=node:users_index(name = 'users_index') MATCH users-[:has_user]-user WHERE user.user_id = '#{user_id}' RETURN user"
		results = $neo.execute_query(query)["data"]

		if results.empty?
			return nil
		end

		return results.first.first
	end

	def find_by_ids(user_ids)
		or_query = user_ids.map{|keyword| "user.user_id = '#{keyword}'"}.join(" or ")
		query = "START users=node:users_index(name = 'users_index') MATCH users-[:has_user]-user WHERE #{or_query} RETURN user"
		
		results = $neo.execute_query(query)["data"]

		if results.empty?
			return nil
		end

		return results.first
	end

	def get_friends
		query = "start users=node:users_index(name = 'users_index') MATCH users-[:has_user]-user-[:friend_with]-friend return user.user_id, collect(friend.user_id) LIMIT 20"
		results = $neo.execute_query(query)["data"]

		return results.map{|user| User.new(user.first, user.last).to_json}
	end

	def get_event_i_should_go
		query = "START users_index=node:users_index(name='users_index') \
			MATCH users_index-[:has_user]-users-[:friend_with]-friends-[:created]-events \
			RETURN users.user_id, collect(distinct events.event_id), collect(distinct friends.user_id) \
			LIMIT 20"
		results = $neo.execute_query(query)["data"]

		data = results.map{|result|
			{
				"user" => result[0],
				"events" => result[1],
				"friends" => result[2]
			}
		}

		
		return data
	end
end
