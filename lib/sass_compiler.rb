require 'haml'
require 'fileutils'

# Sass::Plugin.options[:check_for_updates] = false

class SassCompiler
  
  class NotFound < StandardError; end
  class CompileError < StandardError; end
  
  @asset_folder = "#{Rails.root}/public/stylesheets"
  @cache_folder = "#{Rails.root}/tmp/asset_cache"
  @cached = []
  
  def self.asset_folder=(path)
    @asset_folder = path
  end
  
  def self.cache_folder=(path)
    @cache_folder = path
  end
  
  def self.call(env)
    asset = Array(env["PATH_INFO"].match(/^\/stylesheets\/(.*).css/))[1]
    raise NotFound unless asset and env['REQUEST_METHOD'] == 'GET'
    
    if Rails.env != 'development' and @cached.include? asset
      @cache_server.call(env)
    else
      sass_compile asset
      @cache_server.call(env)
    end
  rescue NotFound
    [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  rescue CompileError => e
    [500, {"Content-Type" => "text/plain"}, [e.inspect]]
  end
  
  # Renders the sass files in the cache and instances an app to serve them
  def self.sass_compile(asset_name)
    asset = File.join(@asset_folder, "#{asset_name}.sass")
    raise NotFound unless File.exists? asset
    
    @cache_server ||= cache_server
    css = File.join(@cache_folder, 'stylesheets', "#{asset_name}.css")
    File.delete(css) if File.exists?(css)
    
    begin
      render_style = RAILS_ENV == 'development' ? :nested : :compressed 
      sass = Sass::Files.tree_for asset, :cache             => true,
                                         :cache_location    => File.join(@cache_folder, '.sass_cache'),
                                         :template_location => @asset_folder,
                                         :load_paths        => compass_paths,
                                         :css_filename      => css,
                                         :filename          => asset,
                                         :style             => render_style
      File.open(css, 'w') {|f| f << sass.render}
    rescue Exception => e
      raise CompileError(e)
    end
    @cached << asset_name
  end
  
  # Ensures a cache folder exists and instantiates the app to serve it.
  def self.cache_server
    FileUtils.makedirs File.join(@cache_folder, 'stylesheets')
    Rack::File.new(@cache_folder)
  end
  
  def self.compass_paths
    Compass::Frameworks::ALL.map {|framework| framework.stylesheets_directory if File.exists?(framework.stylesheets_directory)}
  rescue NameError
    []
  end  
end