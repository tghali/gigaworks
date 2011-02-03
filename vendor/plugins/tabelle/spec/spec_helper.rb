require 'rubygems'

require 'active_support'

module Rails
  logger = ActiveSupport::BufferedLogger.new(File.join(File.dirname(__FILE__), "test.log"))
  silence_warnings { Object.const_set "RAILS_DEFAULT_LOGGER", logger }
end

require 'spec'

require 'action_controller'
require 'action_controller/test_case'
require 'action_view'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
 
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

ActiveRecord::Schema.define :version => 0 do
  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.string  "status",        :default => 'unverified'
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

require 'tabelle'

Spec::Runner.configure do |config|

end
