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
  @lists = List.all()
  erb(:index)
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

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:list)
end

post('/lists') do
  name = params.fetch('name')
  list = List.new({:name => name , :id=> nil})
  list.save()
  @lists = List.all()
  erb(:index)
end

get("/lists/:id/edit") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list_edit)
end

patch("/lists/:id") do
  name = params.fetch("name")
  @list = List.find(params.fetch("id").to_i())
  @list.update({:name => name})
  erb(:list)
end

delete("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  @list.delete()
  @lists = List.all()
  erb(:index)
end
