require 'sinatra'

configure :development do
  use Rack::Reloader
end

get '/' do
  erb :index
end

get '/new' do
  erb :new
end

__END__
@@ layout
<html>
<%= yield %>
</html>

@@ index
index
<a href="/new">New</a>

@@ new
new
<form>
<input type="text" name="author">
<input type="text" name="subject">
<textarea name="contents"></textarea>
</form>