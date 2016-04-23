require 'sinatra'

get '/' do
  result = 'Hello World'
  if params['name'] != nil
     result += params['name']
  end

  return result
end