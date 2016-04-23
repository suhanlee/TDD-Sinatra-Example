require File.expand_path '../spec_helper.rb', __FILE__

describe 'Article Path' do
  it "POST /article/new" do
    body = {:name => 'suhan', :subject => 'today', :contents => 'contetns123'}
    post '/article/new', body.to_json, {'Content-Type' => 'application/json'}

    status = {:article => body, :status => 200}.to_json
    expect(last_response.body).to be_include("status")
  end

  it "GET /article/1" do

    get '/article/0'
    puts last_response.body
    expect(last_response.body).to be_include("status")
  end

  it "POST /article/edit/1" do
    body = {:name => 'suhan', :contents => '1234'}
    post '/article/edit/1', body.to_json, {'Content-Type' => 'application/json'}

    puts last_response.body
    expect(last_response.body).to be_include("status")
  end

  it "DELETE article/1" do
    delete '/article/1'

    puts last_response.body
    expect(last_response.body).to be_include("status")
  end
end
