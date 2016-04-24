require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

require './app.rb'

RSpec.configure do |config|
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end
end
