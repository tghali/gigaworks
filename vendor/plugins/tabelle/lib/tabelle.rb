require 'tabelle/presenter'
require 'tabelle/view'
require 'tabelle/helper'
require 'tabelle/controller'


# ActionController::Base.append_view_path(File.join(File.dirname(__FILE__), 'views'))
# RAILS_DEFAULT_LOGGER.debug "****** #{ActionController::Base.view_paths.join(" - ")}"
ActionView::Base.send(:include, Tabelle::Helper)
ActionController::Base.send(:include, Tabelle::Controller)

# LEDO: Should I require haml? Where: gemspec, loading the plugin or the view helper?
module Tabelle
  class Railtie < Rails::Railtie
    config.tabelle = ActiveSupport::OrderedOptions.new
    
    initializer "tabelle.tabelle" do |app|
      ActiveSupport.on_load(:action_view) do
        include Tabelle::Helper
      end
      
      ActiveSupport.on_load(:action_controller) do
        include Tabelle::Controller
        append_view_path File.expand_path('views',File.dirname(__FILE__))
      end
    end
    
  end
  
  VERSION = File.exist?('VERSION') ? File.read('VERSION') : ""
end