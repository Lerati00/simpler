module Simpler
  class View
    class PlainTemplate
      def initialize(env)
        @env = env
      end

      def render(binding)
        template
      end

      private

      def template
        @env['simpler.template']
      end
    end
  end
end
