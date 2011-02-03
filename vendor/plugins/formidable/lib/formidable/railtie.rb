require 'rails'
require 'formidable'

module Formidable
  class Railtie < Rails::Railtie    
    config.action_view.default_form_builder = Formidable::Builder
  end
end