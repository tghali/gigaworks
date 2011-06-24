class AddColumnClientId < ActiveRecord::Migration
  def self.up
	  add_column :client_addresses,:gigaclient_id,:integer
  end

  def self.down
	  remove_column :client_addresses,:gigaclient_id 
  end
end
