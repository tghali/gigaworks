require 'formidable/builder'
require 'formidable/railtie'

module Formidable
  VERSION = File.exist?('../VERSION') ? File.read('../VERSION').first : ""
end