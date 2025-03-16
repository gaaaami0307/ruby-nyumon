require 'sinatra'
require 'sinatra/activerecord'
require './models/todo'

set :bind, '0.0.0.0'

ActiveRecord::Base.establish_connection(
  YAML.load_file('config/database.yml')[ENV['RACK_ENV'] || 'development']
)

get '/' do
  'Hello, World!'
end

require './db/todos'
get '/todos' do
  @todos = Todo.all
  erb :todos
end

post '/todos' do
  todo=Todo.new
  todo.title=params[:title];
  todo.save
  redirect '/todos'
end

get '/todos/:id/edit' do
  @todo = Todo.find(params[:id])
  erb :edit
end

put '/todos/:id' do
  todo=Todo.find_by(id:params[:id])
  #DB.execute('UPDATE todos SET title = ? WHERE id = ?',[params[:title],params[:id]])
  todo.title=params[:title]
  todo.save
  redirect '/todos'
end

delete '/todos/:id' do
  #DB.execute('DELETE FROM todos WHERE id = ?',[params[:id]])
  todo=Todo.find_by(id:params[:id])
  todo.delete
  redirect '/todos'
end

get '/api/todos' do
  content_type :json
  todos = Todo.all
  response = todos.map { |todo| { id: todo.id, title: todo.title } }
  JSON.pretty_generate(response)
end

#titleを受け取る
post '/api/todos' do
  content_type :json
  title = params[:title]
  todo=Todo.new
  todo.title=params[:title];
  todo.save
  #DB.execute('INSERT INTO todos (title) VALUES (?)',title)
  response={id: todo.id, title: todo.title}
  JSON.pretty_generate(response)
end

get '/api/todos/:id' do
  content_type :json
  #response=DB.execute('SELECT * FROM todos WHERE id=?',[params[:id]]).last
  todos = Todo.find(params[:id])
  response = todos.map { |todo| { id: todo.id, title: todo.title } }
  JSON.pretty_generate(response)
end

put '/api/todos/:id' do
  content_type :json
  todo=Todo.find_by(id:params[:id])
  #DB.execute('UPDATE todos SET title = ? WHERE id = ?',[params[:title],params[:id]])
  todo.title=params[:title]
  todo.save
  #DB.execute('UPDATE todos SET title = ? WHERE id = ?',[title,params[:id]])
  #response=DB.execute('SELECT * FROM todos WHERE id=?',[params[:id]]).last
  response={id: todo.id, title: todo.title}
  JSON.pretty_generate(response)
end

delete '/api/todos/:id' do
  content_type :json
  #DB.execute('DELETE FROM todos WHERE id = ?',[params[:id]])
  todo=Todo.find_by(id:params[:id])
  todo.delete
  response={
    "message": "TODO deleted"
  }
  JSON.pretty_generate(response)
end