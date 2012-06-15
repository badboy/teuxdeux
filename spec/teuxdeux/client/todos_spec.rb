# encoding: utf-8

require 'helper'

describe TeuxDeux::Client::ToDos do
  before do
    @client = TeuxDeux::Client.new(:login => 'user', :password => 'secret')
  end

  describe ".list_todos" do
    it "should return list of todos" do
      stub_get("list.json").
        to_return(:body => fixture("todo_list.json"))

      todos = @client.list_todos
      todos.size.should == 2

      todos[0].id.should == 1
      todos[0].done.should == false
      todos[1].done.should == true
    end
  end

  describe ".list_somedays" do
    it "should return list of someday todos" do
      stub_get("list/someday.json").
        to_return(:body => fixture("someday_list.json"))

      todos = @client.list_somedays
      todos.size.should == 2

      todos[0].id.should == 1337
      todos[0].do_on.should == "1989-12-01"
      todos[0].done.should == true
    end
  end

  describe ".create_todo" do
    it "should return a new todo" do
      stub_post("todo.json").
        with(:body => { :todo_item => {
          :todo => "new todo",
          :do_on => "2011-05-27",
          :done => "0",
          :position => "0"
        }}).
        to_return(:body => fixture("todo.json"))

        t = @client.create_todo("new todo", "2011-05-27")

        t.todo.should == "new todo"
        t.do_on.should == "2011-05-27"
    end
  end

  describe ".create_todo_someday" do
    it "should return a new todo" do
      stub_post("todo.json").
        with(:body => { :todo_item => {
          :todo => "new someday",
          :do_on => "1989-12-01",
          :done => "0",
          :position => "0"
        }}).
        to_return(:body => fixture("someday.json"))

        t = @client.create_todo_someday("new someday")

        t.todo.should == "new someday"
        t.do_on.should == "1989-12-01"
    end
  end

  describe ".update_todo" do
    it "should update a todo item" do
      stub_post("update.json").
        # WebMock does not correctly encode a ruby hash with a integer key, so
        # we do it.
        with(:body => "todo_item%5B12345%5D%5Bdone%5D=1").
        to_return(:body => fixture("update_todo.json"))


      @client.update_todo(12345, :done => true )
    end
  end

  describe ".delete_todo" do
    it "should return true on successful delete" do
      stub_delete("todo/123").
        to_return(:status => 200)

      @client.delete_todo(123).should == true
    end

    it "should return false on unknown id" do
      stub_delete("todo/123456").
        to_return(:status => 500)

      @client.delete_todo(123456).should == false
    end
  end
end
