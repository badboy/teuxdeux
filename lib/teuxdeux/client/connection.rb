require 'faraday_middleware'
require 'faraday/response/raise_error'

module TeuxDeux
  class Client
    # @private
    module Connection
      BASE_URL = "https://teuxdeux.com/api/"
      private

      def connection(raw=false)

        options = {
          :proxy => proxy,
          :ssl => {:verify => false},
          :url => BASE_URL,
        }

        connection = Faraday.new(options) do |builder|
          builder.use Faraday::Request::UrlEncoded
          builder.use Faraday::Response::RaiseError
          unless raw
            builder.use Faraday::Response::Rashify
            builder.use Faraday::Response::ParseJson
          end
          builder.adapter(adapter)
        end
        connection.basic_auth authentication[:login], authentication[:password] if authenticated?
        connection
      end
    end
  end
end
