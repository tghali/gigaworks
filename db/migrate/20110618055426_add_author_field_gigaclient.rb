class AddAuthorFieldGigaclient < ActiveRecord::Migration
  def self.up
	  add_column :gigaclients, :author_id, :integer
	  add_column :gigaclients,:project_manager_id,:string
	  add_column :gigaclients,:pms_url,:string
	  
  end

  def self.down
	    remove_column :gigaclients, :author_id
	    remove_column :gigaclients,:project_manager_id
	  remove_column :gigaclients,:pms_url
  end
end
