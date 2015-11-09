require 'rack/test'
require 'rspec'

require File.expand_path '../../app.rb', __FILE__

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
	include Rack::Test::Methods

	def app
		SimpleApp
	end
end
