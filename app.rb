require 'sinatra'

get '/' do
  'Hello, World!'
end

get '/todos' do
  @todos=['TODO1','TODO2','TODO3']
  erb :todos
end