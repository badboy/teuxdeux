#!/usr/bin/env ruby
# encoding: utf-8

module TeuxDeux
  class Client
    module User
      def user(options={})
        get("user.json", options)
      end
    end
  end
end
