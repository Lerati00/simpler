require 'erb'
require_relative 'view/html_template'
require_relative 'view/plain_template'

module Simpler
  class View
    TEMPLATE_TYPES = { plain: PlainTemplate, html: HtmlTemplate }
    DEFAULT_TEMPLATE = TEMPLATE_TYPES[:html] 

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = TEMPLATE_TYPES[template_type] || DEFAULT_TEMPLATE
      template.new(@env).render(binding)
    end

    private

    def template_type
      @env['simpler.template_type']
    end

  end
end
