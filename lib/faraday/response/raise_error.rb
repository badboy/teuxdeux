require 'faraday'

# @api private
module Faraday
  class Response::RaiseError < Response::Middleware
    def on_complete(response)
      case response[:status].to_i
      when 401
        raise TeuxDeux::Unauthorized, error_message(response)
      when 404
        raise TeuxDeux::NotFound, error_message(response)
      when 500
        raise TeuxDeux::InternalServerError, error_message(response)
      end
    end

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{(': ' + response[:body]) if response[:body]}"
    end
  end
end
