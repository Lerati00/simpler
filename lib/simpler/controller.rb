require_relative 'view'

module Simpler
  class Controller
    CONTENT_TYPES = { plain: 'text/plain', html: 'text/html' }

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      update_route_params

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    def params
      @request.params 
    end

    private

    def update_route_params
      route_params = @request.env['simpler.route_params']
      route_params.each{ |k, v| params[k] = v }
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def render(template)
      if template.is_a?(Hash)
        type = template.keys[0]
        headers['Content-Type'] = CONTENT_TYPES[type]
        @request.env['simpler.template'] = template[type]
        @request.env['simpler.template_type'] = type
      else
        @request.env['simpler.template'] = template
      end
    end

    def status(code)
      @response.status = code
    end

    def headers
      @response
    end

  end
end
