require 'connie/connie'
require 'connie/dictionary'
require 'connie/parser'


module Connie
  
  # class Railtie < Rails::Railtie
  #   config.tabelle = ActiveSupport::OrderedOptions.new
  # 
  #   initializer "tabelle.tabelle" do |app|
  #     ActiveSupport.on_load(:action_view) do
  #       include Tabelle::Helper
  #     end
  # 
  #     ActiveSupport.on_load(:action_controller) do
  #       include Tabelle::Controller
  #       append_view_path File.expand_path('views',File.dirname(__FILE__))
  #     end
  #   end
  # 
  # end
  @dictionaries_paths = [File.expand_path('dictionaries',File.dirname(__FILE__))]
  VERSION = File.exist?('VERSION') ? File.read('VERSION') : ""
  
  def self.dictionaries_paths
    @dictionaries_paths
  end
  
end

# The shorthand method to use connie
# Accepts three kinds of arguments:
# 
# 1) String
#    Connie parses the string replacing the :dictionary.format bits of string with random
#    results from it's dictionaries
# 
# 2) Symbols
#    Uses the symbol to pick the dictionary to return and eventually calls the format on 
#    it.
# 
# 3) Arrays
#    As a form of convenience Connie picks a random element out of the array passed
#
def Connie(argument, options={})
  case argument
  when String
    Connie::Parser.process(argument)
  when Symbol
    argument = argument.to_s.split('.').map &:to_sym
    
    dictionary = Connie[argument.first]
    
    if argument[1]
      dictionary.send argument[1], options
    else
      dictionary
    end
  when Array
    argument[rand(argument.size)]
  when Range
    rand(argument.max-argument.min+1) + argument.min
  else
    raise ArgumentError, 'Connie\'s shorthand expects a string to parse or a symbol or an array'
  end
end

def Connie?
  [true,false][rand 2]
end