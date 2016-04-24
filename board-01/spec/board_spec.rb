require File.expand_path '../spec_helper.rb', __FILE__

module Helpers
  def include_eq(body, included)
    expect(body.include?(included)).to eq(true)
  end
end

RSpec.configure do |c|
  c.include Helpers
end

describe 'Board Path (/)' do

  before(:each) do
    @browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
  end

  it "should return index string" do
    @browser.get '/'
    body = @browser.last_response.body
    include_eq(body, 'index')
  end

  it "find new page link" do
    NEW_LINK = '<a href="/new">New</a>'
    @browser.get '/'
    body = @browser.last_response.body
    include_eq(body, NEW_LINK)
  end
end

describe 'Board Path (/new)' do
  before(:each) do
    @browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
  end

  it "find form field in new page" do
    AUTHOR_FORM_FIELD = '<input type="text" name="author">'

    @browser.get '/new'
    body = @browser.last_response.body
    include_eq(body, AUTHOR_FORM_FIELD)
  end

  it "find subject form in new page" do
    SUBJECT_FORM_FIELD = '<input type="text" name="subject">'

    @browser.get '/new'
    body = @browser.last_response.body
    include_eq(body, SUBJECT_FORM_FIELD)
  end

  it "find contents form in new page" do
    CONTENTS_FORM_FIELD = '<textarea name="contents"></textarea>'

    @browser.get '/new'
    body = @browser.last_response.body
    include_eq(body, CONTENTS_FORM_FIELD)
  end
end