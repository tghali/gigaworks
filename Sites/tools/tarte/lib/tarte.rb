require 'tarte/baked_in_associations'
require 'tarte/baked_in_validation_helpers'

  # base.extend BakedInValidationHelpers
  # base.extend BakedInAssociations

module Tarte
  
  class Railtie < Rails::Railtie
    config.tarte = ActiveSupport::OrderedOptions.new
    
    initializer "tarte.extend_activerecord" do |app|
      ActiveSupport.on_load(:active_record) do
        extend BakedInValidationHelpers
        extend BakedInAssociations
      end
    end
    
  end
  
  VERSION = File.exist?('VERSION') ? File.read('VERSION') : ""
end