class AddFieldsInvite < ActiveRecord::Migration
  def self.up
	  add_column :invites,:event_id,:string
	  add_column :invites,:event_type,:string
  end

  def self.down
	  remove_column :invites,:event_id
	  remove_column :invites,:event_type
  end
end
