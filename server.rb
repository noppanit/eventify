require 'require_all'
require 'sinatra'
require 'neography'
require 'json'
require 'require_all'
require 'haml'

require_all 'lib'

$neo = Neography::Rest.new("http://127.0.0.1:7476")

get '/' do
	haml :index
end

get '/get_friends' do
	user_finder = UserFinder.new

	return user_finder.get_friends.to_json
end


