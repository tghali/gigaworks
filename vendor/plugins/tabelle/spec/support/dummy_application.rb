RAILS_ROOT = ""
require 'haml'
%w[haml/template].each {|f| require f}

# ActionView::Base.register_template_handler(:haml, Haml::Plugin)

ActionController::Routing::Routes.draw do |map|
  map.connect ":controller/:action/:id"
end
 
class ApplicationController < ActionController::Base
end


ActionController::Base.append_view_path(File.dirname(__FILE__)+"/views")

