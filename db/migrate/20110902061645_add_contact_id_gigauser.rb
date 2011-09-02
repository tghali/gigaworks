class AddContactIdGigauser < ActiveRecord::Migration
  def self.up
	   add_column :gigausers, :client_contact_id,:integer
	   add_column :gigausers, :deleted_at,:datetime
  end

  def self.down
	  remove_column :gigausers, :client_contact_id
	   remove_column :gigausers, :deleted_at
  end
end
