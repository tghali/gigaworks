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
    
       config.time_zone = 'UTC'

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
      ['--None--', :Mr, :Ms , :Mrs, :Dr, :Professor, :Miss, :Reverend, :Major, :Lady, :Sir ]
    end  
    
            def self.exp_years
      ['2011', '2010', '2009', '2008','2007','2006','2005','2004','2003','2002','2001','2000','1999','1998','1997','1996','1995','1994','1993','1992','1991','1990' ]
    end
    
        def self.year_details
      ['0', '1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30' ]
    end
    
     def self.month_details
      ['0', '1', '2', '3','4','5','6','7','8','9','10','11']
    end
 
    
    def self.currency_convert
      ['AUD - Australian Dollar','CAD - Canadian Dollar','CHF - Swiss Franc','CNY - Chinese Yuan Renminbi','DKK - Danish Krone','EUR - Euro','GBP - British Pound','HKD - Hong Kong Dollar','HUF - Hungarian Forint','INR - Indian Rupee','JPY - Japanese Yen','MXN - Mexican Peso','MYR - Malaysian Ringgit','NOK - Norwegian Krone','NZD - New Zealand Dollar','PHP - Philippine Peso','RUB - Russian Ruble','SEK - Swedish Krona','SGD - Singapore Dollar','THB - Thai Baht','TRY - Turkish Lira','USD - US Dollar','ZAR - South African Rand','AUD - Australian Dollar','AED - Emirati Dirham','AFN - Afghan Afghani','ALL - Albanian Lek','AMD - Armenian Dram','ANG - Dutch Guilder','AOA - Angolan Kwanza','ARS - Argentine Peso','AWG - Aruban or Dutch Guilder','AZN - Azerbaijani New Manat']
    end
    

        def self.industries
	    [:Education, :Entertainment, 'FMCG manufacturers']
    end
 
     def self.turnovers
	    ["Up to 249k",'250k to 499k','500k to 0.9m','1m to 1.9m','2m to 2.9m','3m to 4.9m','5m to 7.49m','7.5m to 9.9m','10m to 14.9m','15m to 20m','20m to 150m','151m to 500m','501m to 999m','1b to 5b', 'over 5b']
    end

    
            def self.lead_status
      [:New, :Contacted, :Qualified, :Converted,:Rejected]
    end
   
        def self.lead_source
      [ :Campaign, :Conference, :ColdCall,'Online Marketing','Referral','Website','Other']
    end
    
         def self.lead_score
      ['1','2','3','4','5']
    end

    
        
         def self.employees
	    ['Unknown','1 Employees','2 Employees','3 Employees','4 Employees','5 Employees','6-9 Employees','10-19 Employees', '20-49 Employees','50-99 Employees','100-199 Employees','200-299 Employees','300-399 Employees','400-499 Employees','500-749 Employees','750-999 Employees','1000-1499 Employees','1500-1999 Employees','2000-4999 Employees','5000-9999 Employees','100,000 Plus Employees']
    end
   
        def self.client_contacts
          
           ['Editor','Project Manager','Client','Translator']
          

    end


  end
  
end
