require File.expand_path '../spec_helper.rb', __FILE__

describe 'Hello Path' do
	it "should return hello string" do
		get '/hello'
		
		expect(last_response.body).to eq("hello")
	end
end
