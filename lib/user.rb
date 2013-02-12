class User
	attr_accessor :user_id, :friend_ids

	def initialize(user_id, friend_ids)
		@user_id = user_id
		@friend_ids = friend_ids
	end	

	def to_json
        {'user_id' => @user_id, 'friend_ids' => @friend_ids}.to_json
    end
end