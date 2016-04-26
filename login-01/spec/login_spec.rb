require File.expand_path '../spec_helper.rb', __FILE__

describe 'Login Path(/login)' do
  it 'show login input-form' do
    user_name_tag = '<input type="text" name="user_name"'
    password_tag = '<input type="password" name="password"'
    get '/login'
    expect(last_response.ok?).to eq(true)
    expect(last_response.body).to include(user_name_tag)
    expect(last_response.body).to include(password_tag)
  end

  it 'after login, redirect to root or not' do
    # right login
    user_name = 'testid'
    password = 'password'
    post '/login', :user_name => user_name, :password => password

    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to eq('http://example.org/')

    # wrong login
    user_name = 'abcd'
    password = '123'
    post '/login', :user_name => user_name, :password => password
    expect(last_response.ok?).to eq(true)
  end

  it 'try login with wrong user_name and display error message' do
    # right login
    user_name = 'testid'
    password = 'password'
    post '/login', :user_name => user_name, :password => password
    get '/'

    expect(last_response.body).not_to include('Login Error')

    # wrong login
    user_name = 'abcd'
    password = '123'
    post '/login', :user_name => user_name, :password => password
    get '/'

    expect(last_response.body).to include('Login Error')
  end

end