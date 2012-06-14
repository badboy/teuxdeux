module TeuxDeux
  class Client
    module ToDos
      def list_todos(options={})
        get("list.json", options)
      end
      alias :todos :list_todos

      def list_somedays(options={})
        get("list/someday.json", options)
      end
      alias :someday :list_somedays

      def create_todo(todo, do_on, done=false, position=0, options={})
        post("todo.json", options.merge({
          :todo_item => {
            :todo => todo,
            :do_on => do_on,
            :done => done ? 1 : 0,
            :position => position
          }
        }))
      end

      def create_todo_someday(todo, done=false, position=0, options={})
        create_todo(todo, "1989-12-01", done, position, options)
      end

      def update_todo(todos, options={})
        data = todos.inject({:todo_item => {}}) do |h, (todo_id,opts)|
          opts[:done] = opts[:done] ? 1 : 0 if opts[:done]
          h[:todo_item][todo_id] = opts
          h
        end
        post("update.json", options.merge(data))
      end

      def delete_todo(id, options={})
        # TeuxDeux returns an 500 status code and
        # HTML body on invalid IDs
        # => catch that
        delete("todo/#{id}", options, true).status == 200
      rescue InternalServerError
        false
      end
    end
  end
end
