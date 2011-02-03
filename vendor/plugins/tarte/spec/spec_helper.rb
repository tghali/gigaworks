require 'active_support'
require 'active_record'
require 'rspec'

TEST_DATABASE_FILE = File.join(File.dirname(__FILE__), '..', 'test.sqlite3')
 
File.unlink(TEST_DATABASE_FILE) if File.exist?(TEST_DATABASE_FILE)

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3", "database" => TEST_DATABASE_FILE
)
 
# RAILS_DEFAULT_LOGGER = Logger.new(File.join(File.dirname(__FILE__), "debug.log"))
 
load(File.dirname(__FILE__) + '/schema.rb')

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

#Mock ActiveRecord
# module ActiveRecord
#   class Base
#   end
# end

require 'tarte'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  
end
