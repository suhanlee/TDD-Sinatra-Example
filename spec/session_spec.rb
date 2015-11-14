require File.expand_path '../spec_helper.rb', __FILE__

describe 'session path' do
  before do
    post '/session/test/1234'
  end
  it "set session data" do
    get '/session/test'

    expect(last_response.body).to eq("1234")
  end
end