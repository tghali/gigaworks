class AddClientContactDeleteAt < ActiveRecord::Migration
  def self.up
	  add_column :client_contacts, :deleted_at,:datetime
  end

  def self.down
	  remove_column :client_contacts, :deleted_at
  end
end
