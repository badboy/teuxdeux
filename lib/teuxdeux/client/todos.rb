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

      def create_todo(todo, do_on, done=false, position=0)
        post("todo.json", {
          :todo_item => {
            :todo => todo,
            :do_on => do_on,
            :done => done ? 1 : 0,
            :position => position
          }
        })
      end

      def create_todo_someday(todo, done=false, position=0)
        create_todo(todo, "1989-12-01", done, position)
      end

      def update_todo(todo_id, opts={})
        params = { todo_id => {} }

        # Be explicit on what options can be set.
        params[todo_id][:done]     = opts.delete(:done) ? 1 : 0 if opts.has_key? :done
        params[todo_id][:position] = opts.delete(:position)     if opts.has_key? :position
        params[todo_id][:do_on]    = opts.delete(:do_on)        if opts.has_key? :do_on
        params[todo_id][:todo]     = opts.delete(:todo)         if opts.has_key? :todo

        post("update.json", :todo_item => params)
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
