class Task
  attr_reader(:description, :list_id)
  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @list_id = attributes[:list_id]
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      tasks.push(Task.new({:description=> description, :list_id=>list_id}))
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id})")
  end

  def == (another_task)
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end
end

class List
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end
end
