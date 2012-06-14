module TeuxDeux
  class Client
    module Request
      def get(path, options={}, raw=false)
        request(:get, path, options, raw)
      end

      def post(path, options={}, raw=false)
        request(:post, path, options, raw)
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
            if !options.empty?
              if options.kind_of? Hash
                # Correctly format a hash as urlencoded string.
                request.body = hash_to_params options
              else
                request.body = options
              end
            end
          end
        end
        raw ? response : response.body
      end

    end
  end
end

