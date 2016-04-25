require File.expand_path '../spec_helper.rb', __FILE__

describe 'Login Path(/login)' do
  it 'show login input-form' do
    get('/login')
    expect(last_response.ok?).to eq(true)
  end
end