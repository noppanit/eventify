START users_index=node:users_index(name='users_index') match users_index-[:has_user]-users-[:created]-events where not(events.c_1 = "0") return users.user_id, events


Find my friends
START users_index=node:users_index(name='users_index') 
MATCH users_index-[:has_user]-users-[:friend_with]-friends 
RETURN users.user_id, collect(friends.user_id)


Find friends who go to the events I created
START users_index=node:users_index(name='users_index') 
MATCH users_index-[:has_user]-users-[:created]-events-[:yes]-friends-[:friend_with]-users 
RETURN users.user_id, collect(friends.user_id)

Find event that my friends created
START users_index=node:users_index(name='users_index') 
MATCH users_index-[:has_user]-users-[:friend_with]-friends-[:created]-events
RETURN users.user_id, collect(events.event_id)

Friends of a friends
START users=node:users_index(name = 'users_index') 
MATCH users-[:has_user]-user-[:friend_with]-friend-[:friend_with]-fof 
RETURN user.user_id, collect(friend.user_id), collect(fof.user_id) LIMIT 20