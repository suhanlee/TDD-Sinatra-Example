require File.expand_path '../spec_helper.rb', __FILE__

describe 'Login Path(/login)' do
  it 'show login input-form' do
    user_name_tag = '<input type="text" name="user_name"'
    password_tag = '<input type="password" name="password"'
    get('/login')
    expect(last_response.ok?).to eq(true)
    expect(last_response.body).to include(user_name_tag)
    expect(last_response.body).to include(password_tag)
  end
end