module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && check_path(path)
      end

      private

      def check_path(path)
        route = @path.split('/').compact
        request = path.split('/').compact
        return false unless route.size == request.size
        route.each_with_index do |path, index| 
          if path[0] == ':'
            param_symbol = path[1..path.size].to_sym
            @params[param_symbol] = request[index]
          else
            return false unless path == request[index]
          end
        end
      end

    end
  end
end
