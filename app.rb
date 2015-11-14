require 'sinatra'
require 'gdbm'
require 'json'

configure :development do
	use Rack::Reloader
end

class SimpleApp < Sinatra::Base

	before '/hash/*' do
		@gdbm = GDBM.new("db/keyvalue.db")
	end

	after '/hash/*' do
		@gdbm.close
	end

	get '/' do
	end

	get '/hello' do
		"hello"
	end

	get '/hash/set/:name/:value' do
		name = params[:name]
		value = params[:value]

		begin
			@gdbm["#{name}"] = value
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end

		"{ #{name}: #{value} }"
	end

	get '/hash/get/:name' do
		name = params[:name]

		begin
			value = @gdbm["#{name}"]
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
