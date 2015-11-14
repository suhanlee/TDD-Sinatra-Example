require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__


RSpec.configure do |config|
	include Rack::Test::Methods

	def app
		SimpleApp
	end
end
