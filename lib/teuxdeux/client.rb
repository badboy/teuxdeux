require 'teuxdeux/client/authentication'
require 'teuxdeux/client/connection'
require 'teuxdeux/client/request'
require 'teuxdeux/client/user'
require 'teuxdeux/client/todos'

module TeuxDeux
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = TeuxDeux.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include TeuxDeux::Client::Authentication
    include TeuxDeux::Client::Connection
    include TeuxDeux::Client::Request

    include TeuxDeux::Client::User
    include TeuxDeux::Client::ToDos


    # From:
    #   http://stackoverflow.com/questions/798710/how-to-turn-a-ruby-hash-into-http-params
    def hash_to_params(hash)
      params = ''
      stack = []

      hash.each do |k, v|
        if v.is_a?(Hash)
          stack << [k,v]
        else
          v = URI.escape v.to_s
          params << "#{k}=#{v}&"
        end
      end

      stack.each do |parent, hash|
        hash.each do |k, v|
          if v.is_a?(Hash)
            stack << ["#{parent}[#{k}]", v]
          else
            v = URI.escape v.to_s
            params << "#{parent}[#{k}]=#{v}&"
          end
        end
      end

      params.chop! # trailing &
      params
    end
  end
end
