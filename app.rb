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
  redirect '/todos'
end

get '/todos/:id/edit' do
  @todo = DB.execute('SELECT * FROM todos WHERE id = ?',[params[:id]]).first
  erb :edit
end

put '/todos/:id' do
  DB.execute('UPDATE todos SET title = ? WHERE id = ?',[params[:title],params[:id]])
  redirect '/todos'
end

delete '/todos/:id' do
  DB.execute('DELETE FROM todos WHERE id = ?',[params[:id]])
  redirect '/todos'
end

get '/api/todos' do
  content_type :json
  todos=DB.execute('SELECT * FROM todos')
  JSON.pretty_generate(todos)
end

#titleを受け取る
post '/api/todos' do
  content_type :json
  title = params[:title]
  DB.execute('INSERT INTO todos (title) VALUES (?)',title)
  response=DB.execute('SELECT * FROM todos WHERE title=?',title).last
  JSON.pretty_generate(response)
end