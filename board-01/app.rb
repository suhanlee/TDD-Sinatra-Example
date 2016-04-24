require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require './model/article'

set :database, {adapter: "sqlite3", database: "database.sqlite3"}

get '/' do
  @total_article = Article.count
  @articles = Article.all
  erb :index
end

get '/new' do
  erb :new
end

get '/edit/:id' do
  @id = params[:id]
  @article = Article.find(@id)
  erb :edit
end

post '/new' do
  author = params[:author]
  subject = params[:subject]
  contents = params[:contents]

  article = Article.new(:author => author, :subject => subject, :contents => contents)
  if article.save
    erb :created, :locals => { :result => "success" }
    redirect to('/')
  else
    erb :created, :locals => { :result => "error" }
  end
end

post '/edit/:id' do
  id = params[:id]
  author = params[:author]
  subject = params[:subject]
  contents = params[:contents]

  article = Article.find(id)
  article.author = author
  article.subject = subject
  article.contents = contents

  if article.save
    erb :created, :locals => { :result => "success" }
    redirect to('/')
  else
    erb :created, :locals => { :result => "error" }
  end
end

__END__
@@ layout
<html>
<%= yield %>
</html>