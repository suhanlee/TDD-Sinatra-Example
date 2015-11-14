require File.expand_path '../spec_helper.rb', __FILE__

describe 'session path' do
  it "/session/test/1234" do
    session = {}
    post '/session/test/1234', {}, {'rack.session' => session}

    expect(last_response.body).to eq(session["test"])
  end

  it "/session/test" do
    get '/session/test', {}, {'rack.session' => {"test" => "1234"}}
    expect(last_response.body).to eq("1234")
  end
end