require 'sinatra'

get '/' do
  'Hello, World!'
end

require './db/todos'
get '/todos' do
  @todos = DB.execute('SELECT * FROM todos')
  erb :todos
end

post '/todos' do
  DB.execute('INSERT INTO todos (title) VALUES (?)', [params[:title]])
  @todos = DB.execute('SELECT * FROM todos')
  erb :todos
end

get '/todos/:id/edit' do
  @todo = DB.execute('SELECT * FROM todos WHERE id = ?',[params[:id]]).first
  erb :edit
end

put '/todos/:id/edit' do
  DB.execute('UPDATE todos SET title = (?) WHERE id = :id',[params[:title]])
  @todos = DB.execute('SELECT * FROM todos')
  erb :todos
end