require('pry')
require('launchy')
require('sinatra')
require('sinatra/reloader')
require('./lib/todo')
also_reload('./**/*.rb')

get('/') do
  erb(:index)
end

post('/result') do
  test_todo = ToDo.new(params.fetch('task'))
  test_todo.save()
  @todo = test_todo.description()
  erb(:result)
end
