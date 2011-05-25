module TeuxDeux
  class Client
    module Authentication
      def authentication
        if login && password
          {:login => login, :password => password}
        else
          {}
        end
      end

      def authenticated?
        !authentication.empty?
      end
    end
  end
end
