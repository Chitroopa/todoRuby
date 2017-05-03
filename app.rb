require('pry')
require('launchy')
require('sinatra')
require('sinatra/reloader')
require('./lib/list')
require('./lib/task')
require('pg')
also_reload('./**/*.rb')

DB = PG.connect({:dbname=>'to_do_test'})

get('/') do
  erb(:index)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

get('/lists/new') do
  erb(:list_form)
end

get('/lists/:id') do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/lists/:id") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:list)
end

post('/lists') do
  name = params.fetch('name')
  task = params.fetch('task')
  list = List.new({:name => name , :id=> nil})
  list.save()
  task = Task.new({:description => task, :list_id => list.id()})
  task.save()
  @lists = List.all()
  erb(:lists)
end
