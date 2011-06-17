require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Gigavine
  class Application < Rails::Application
  
    config.generators do |g|
      g.template_engine :haml
      g.orm             :active_record
      g.test_framework  :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)
    
    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    
    config.middleware.use OmniAuth::Builder do
      # provider :twitter,  ENV['TWITTER_KEY'],  ENV['TWITTER_SECRET']
      provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
    end
    
    config.middleware.use Warden::Manager do |manager|
      manager.default_strategies :remember_me
      manager.failure_app = SessionsController.action(:unauthorized)
      
      manager.serialize_into_session { |user| [user.id, user.salt] }
      manager.serialize_from_session do |session_key|
        User.authenticate_from_session(*session_key)
      end
    end
    
    config.middleware.delete 'Sass::Plugin::Rack'
    
    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery.js jquery-ui.js rails.js)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]    
  end
  
  module Preferences
    
    def self.site_sections
      %w(company creative languages technology contact_us legal)
    end
    
    def self.site_locales
      [:ar, :de, :en, :es, :fr]
    end
    
    def self.translated_languages
      [:en, :ar, :de, :es, :fr, :it, :ja, :zh, :hi, :th]
    end
    
    def self.contact_detail_types
      [:work, :personal, :reception, :home, :mobile]
    end
    
     def self.suffixes
      [:Mr, :Ms , :Mrs, :Dr ]
    end  
    
  end
  
end
