require File.expand_path '../spec_helper.rb', __FILE__

describe 'File Upload Path' do
  it "POST /upload/:filename" do
    post '/upload/test1.txt'

    expect(last_response.body).to be_include("status")
  end
end
