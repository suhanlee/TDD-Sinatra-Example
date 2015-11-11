require 'sinatra'
require 'gdbm'

configure :development do
	use Rack::Reloader
end

class SimpleApp < Sinatra::Base
	get '/' do
	end

	get '/hello' do
		"hello"
	end

	get '/set/:name/:value' do

		name = params[:name]
		value = params[:value]

		gdbm = GDBM.new("db/keyvalue.db")
		gdbm["#{name}"] = value
		gdbm.close

		"{ #{name}: #{value} }"
	end

	get '/get/:name' do
		name = params[:name]
		gdbm = GDBM.new("db/keyvalue.db")
		value = gdbm["#{name}"]
		gdbm.close

		"{ #{name}: #{value} }"
	end
end
