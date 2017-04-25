require('rspec')
require('todo')
require('pry')

describe(ToDo) do
  before() do
    ToDo.clear()
  end

  describe('#description') do
    it("will let you enter a string") do
      test_todo = ToDo.new("a string")
      expect(test_todo.description()).to(eq("a string"))
    end
  end

  describe('#save') do
    it("will let you enter a string") do
      test_todo = ToDo.new("a string")
      expect(test_todo.save()).to(eq(["a string"]))
    end
  end

  describe('.all') do
    it("will display all to do tasks") do
      test_todo = ToDo.new("a string")
      test_todo.save()
      expect(ToDo.all()).to(eq(["a string"]))
    end
  end

  describe('.clear') do
    it("will clear all to do tasks") do
      test_todo = ToDo.new("a string").save()
      expect(ToDo.clear()).to(eq([]))
    end
  end

end
