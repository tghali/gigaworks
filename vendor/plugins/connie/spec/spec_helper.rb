$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'
# optionally add autorun support
require 'rspec/autorun'

require 'connie'

Connie.dictionaries_paths << File.expand_path('test_dictionaries', File.dirname(__FILE__))
Rspec.configure do |c|
  c.mock_with :rspec
end