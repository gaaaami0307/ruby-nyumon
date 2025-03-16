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