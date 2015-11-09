require 'sinatra'

configure :development do
	use Rack::Reloader
end

class SimpleApp < Sinatra::Base
	get '/' do
	end

	get '/hello' do
		"hello"
	end
end
