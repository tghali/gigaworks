class AddFieldGigadomain < ActiveRecord::Migration
  def self.up
	  remove_column :gigadomains,:owner_id
	  add_column :gigadomains,:gigaclient_id,:integer
  end

  def self.down
	  remove_column :gigadomains,:gigaclient_id
	  add_column :gigadomains,:owner_id
  end
end
