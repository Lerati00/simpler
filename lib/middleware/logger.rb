require 'logger'

class AppLogger

  def initialize(app, **options)
    @app = app
    @logger = Logger.new(options[:logdev] || STDOUT)
  end

  def call(env)
    status, headers, body = @app.call(env)
    log = log(env, status, headers)
    puts log

    @logger.info(log)
    [status, headers, body]
  end

  private

  def log(env,status,headers)
    <<~LOG 
      Request: #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}
      Handler: #{env['simpler.controller'].class}##{env['simpler.action']}
      Parameters: #{env['simpler.controller'].params}
      Response: #{status} [#{headers['Content-Type']}] #{env['simpler.template']}
      ------------------------------------------------------------  
    LOG
  end

end