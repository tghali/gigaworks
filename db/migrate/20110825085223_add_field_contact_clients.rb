class AddFieldContactClients < ActiveRecord::Migration
  def self.up
	  add_column :client_contacts,:gigauser_id,:int,:default => nil
	  add_column :client_contacts,:login_access,:string,:default => "open"
  end

  def self.down
	  remove_column :client_contacts,:gigauser_id
	  remove_column :client_contacts,:login_access
  end
end
