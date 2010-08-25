# Wheel clamp is a simple rack middleware I keep in place while I'm developing
# applications in alpha state. It ensures that every http communication with
# the app is authenticated using http-digest authentication

class WheelClamp
  
  def initialize(app)
    @app = app
  end

  def call(env)
    
    auth = Rack::Auth::Digest::MD5.new(@app) do |username| 
      "fig46&arnest" if username == "gigavine"
    end    
    auth.opaque = $$.to_s  # or your favorite opaque 
    auth.realm = 'Gigaworks Alpha'
    
    return auth.call(env) # returns 401 if not authenticated
  end
  
end