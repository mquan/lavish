class UseWWW
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if env['HTTP_HOST'] =~ /^www\./i
      @app.call(env)
    else
      [301, { 'Location' => Rack::Request.new(env).url.sub(/http:\/\//i, 'http://www.') }, ['Redirecting...']]
    end    
  end
end