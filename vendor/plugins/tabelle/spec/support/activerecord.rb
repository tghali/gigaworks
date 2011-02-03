require 'active_record'

ActiveRecord::Base.establish_connection("adapter" => "sqlite3", "database" => ":memory:")
ActiveRecord::Migration.verbose = false

# RAILS_DEFAULT_LOGGER = Logger.new(File.join(File.dirname(__FILE__), "debug.log"))
