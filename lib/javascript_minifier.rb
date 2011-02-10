require 'jsmin'
require 'fileutils'
require 'benchmark'

module JavascriptMinifier
  
  class NotFound < StandardError; end
  
  class Responder
    @asset_folder = "#{Rails.root}/public/javascripts"
    @cache_folder = "#{Rails.root}/tmp/asset_cache"
    @cached = []
  
    def self.asset_folder=(path)
      @asset_folder = path
    end
  
    def self.cache_folder=(path)
      @cache_folder = path
    end
  
    def self.call(env)
      bundle = Array(env["PATH_INFO"].match(/^\/javascripts\/(.*).js/))[1]
      case Rails.env
      when 'production'
        #TODO: deal with etag headers/cachebusters
        if @cached.include? bundle        
          @cache_server.call(env)
        else
          prepare bundle
          @cache_server.call(env)
        end
      else
        serve files_for(bundle)
      end
    rescue NotFound
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  
    # Loads asset files inside the <bundle_name> folder in order:
    #   1.javascripts contained in <bundle_name>/base
    #   2.javascripts contained in <bundle_name>/pugins
    #   3.javascripts contained in the <bundle_name> folder
    def self.files_for(bundle)
      raise NotFound unless File.exists? File.join(@asset_folder, bundle)
      assets = []
      Dir.chdir File.join(@asset_folder, bundle) do
        assets += Dir.glob('base/*.js')
        assets += Dir.glob('plugins/*.js')
        assets += Dir.glob('*.js')
      
        assets.map! {|p| File.expand_path p}
      end  
      assets
    end
  
    # Reads each asset file in order and sends back the content
    def self.serve(assets)
      content = ""
      assets.each do |f|
        content << File.read(f)
      end
      [200, {"Content-Type" => "text/javascript", "Content-Length" => "#{content.bytesize}"}, [content]]
    end
  
    # Compresses the javascript and instantiates the rack server to serve the cached copy
    def self.prepare(bundle)
      cache_file = File.join(@cache_folder, 'javascripts', "#{bundle}.js")
      @cache_server ||= cache_server
    
      script = files_for(bundle).inject(' ') do |s, f|
        s << File.read(f)
      end
    
      File.open(cache_file, "w") { |f| f.puts script } #JSMin.minify(script)
    
      @cached << bundle
    end
  
    def self.cache_server
      FileUtils.mkdir_p File.join(@cache_folder, 'javascripts')
      rack_file = Rack::File.new(@cache_folder)
    
      lambda do |env|
        code, header, body = rack_file.call(env)
        [code, header.merge('Content-Type' => 'text/javascript'), body]
      end
    
    end
    
  end
  
  def self.call(env)
    response = nil
    js_runtime = Benchmark.ms {response = Responder.call(env)}
    Rails.logger.debug("Completed #{response.first} in %.1fms" % js_runtime)
    
    response
  end
  
end