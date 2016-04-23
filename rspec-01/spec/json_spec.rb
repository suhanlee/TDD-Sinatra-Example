require File.expand_path '../spec_helper.rb', __FILE__

describe 'Json Path' do
  describe 'json/' do
    let(:body) { { :version => "1.2.3" }.to_json }
    before do
      post '/json', body, {'Content-Type' => 'application/json'}
    end

    it 'is successful' do
      expect(last_response.body).to eq body
    end
  end
end