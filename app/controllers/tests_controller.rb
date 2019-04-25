class TestsController < Simpler::Controller

  def index
    headers['X-Header'] = 'Hello'
    render plain: 'Hello'
  end

  def create

  end

  def show
  end

end
