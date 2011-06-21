class AddGroupFieldContact < ActiveRecord::Migration
  def self.up
	  add_column :contacts, :group_id, :integer
  end

  def self.down
	  remove_column :contacts, :group_id
  end
end
