require 'sinatra'
require 'gdbm'
require 'json'

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

		begin
			gdbm = GDBM.new("db/keyvalue.db")
			gdbm["#{name}"] = value
			gdbm.close
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end

		"{ #{name}: #{value} }"
	end

	get '/get/:name' do
		name = params[:name]

		begin
			gdbm = GDBM.new("db/keyvalue.db")
			value = gdbm["#{name}"]
			gdbm.close
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end

		"{ #{name}: #{value} }"
	end

	post '/json' do
		begin
			payload = JSON.parse(request.body.read)
			payload.to_json
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end

	end
end
