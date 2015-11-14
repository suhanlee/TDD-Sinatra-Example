require 'sinatra'
require 'gdbm'
require 'json'

require 'sinatra/activerecord'

require './model/article'

configure :development do
	use Rack::Reloader
end

class SimpleApp < Sinatra::Base
	register Sinatra::ActiveRecordExtension

	set :database, {adapter: "sqlite3", database: "database.sqlite3"}

	enable :sessions unless test?

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

	get '/session/:name' do
		name = params[:name]
		session[name].to_s
	end

	post '/session/:name/:data' do
		name = params[:name]
		data = params[:data]
		session[name] = data

		session[name].to_s
	end

	post '/article/new' do
		body = JSON.parse(request.body.read)

		article = Article.new(body)
		if article.save
			status = {:article => article, :status => 200}.to_json
		else
			status = {:article => body, :status => 500}.to_json
		end
	end

	get '/article/:id' do
		id = params[:id]
		begin
			article = Article.find(id)
			status = {:article => article, :status => 200}.to_json
		rescue Exception => e
			status = {:error_message => e.message, :status => 500}.to_json
		end

		status
	end

	post '/article/edit/:id' do
		payload = JSON.parse(request.body.read)

		id = params[:id]
		begin
			article = Article.find(id)
			article.name = payload["name"]
			article.subject = payload["subject"] if payload["subject"] != nil
			article.contents = payload["contents"]
			article.save

			status = {:article => article, :status => 200}.to_json
		rescue Exception => e
			status = {:error_message => e.message, :status => 500}.to_json
		end

		status
	end

	delete '/article/:id' do
		id = params[:id]
		begin
			article = Article.find(id)
			article.destroy
			status = {:status => 200}.to_json
		rescue Exception => e
			status = {:error_message => e.message, :status => 500}.to_json
		end

		status
	end

end
