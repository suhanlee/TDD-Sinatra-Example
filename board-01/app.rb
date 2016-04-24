require 'sinatra'
require 'sinatra/activerecord'
require './model/article'

configure :development do
  use Rack::Reloader
end

set :database, {adapter: "sqlite3", database: "database.sqlite3"}

get '/' do
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  author = params[:author]
  subject = params[:subject]
  contents = params[:contents]

  article = Article.new(:author => author, :subject => subject, :contents => contents)
  if article.save
    erb :created, :locals => { :result => "success" }
  else
    erb :created, :locals => { :result => "error" }
  end
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
<form action="/new" method="POST">
<input type="text" name="author">
<input type="text" name="subject">
<textarea name="contents"></textarea>
<input type="submit" value="send">
</form>

@@ created
new article saved.
<%= result %>
