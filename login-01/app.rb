require 'sinatra'

enable :sessions

get '/' do
  'Login Error' if get_error_session!
end

get '/login' do
    erb :login_form
end

post '/login' do
  user_name = params[:user_name]
  password = params[:password]
  if user_name == 'testid' && password == 'password'
    redirect to('/')
  else
    session[:error] = true
  end
end

def get_error_session!
  if session[:error]
    error = session[:error]
    session[:error] = nil
    return error
  end
end