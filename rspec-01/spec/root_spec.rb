require File.expand_path '../spec_helper.rb', __FILE__

describe 'Root Path' do
	describe 'GET /' do
		before { get '/' }

		it 'is successful' do
			expect(last_response).to be_ok
		end
	end
end

