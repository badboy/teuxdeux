module TeuxDeux
  class Client
    module Request
      def get(path, options={}, raw=false)
        request(:get, path, options, raw)
      end

      def post(path, options={}, raw=false)
        request(:post, path, options, raw)
      end

      def put(path, options={}, raw=false)
        request(:put, path, options, raw)
      end

      def delete(path, options={}, raw=false)
        request(:delete, path, options, raw)
      end

      private

      def request(method, path, options, raw)
        response = connection(raw).send(method) do |request|
          case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = options unless options.empty?
          end
        end
        raw ? response : response.body
      end

    end
  end
end

