ENV['RACK_ENV'] = 'test'

require './hello'
require 'test/unit'
require 'rack/test'

class HelloWorldTest < Test::Unit::TestCase
  def setup
    @browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
  end

  def test_it_says_hello_world
    @browser.get '/'

    assert @browser.last_response.ok?
    assert_equal 'Hello World', @browser.last_response.body
  end

  def test_it_says_hello_to_a_person
    @browser.get '/', :name => 'Simon'

    assert @browser.last_response.body.include?('Simon')
  end
end