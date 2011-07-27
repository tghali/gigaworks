class ChangeFieldtypeInvite < ActiveRecord::Migration
  def self.up
    remove_column :invites,:event_id
    add_column :invites,:event_id,:integer
    
  end

  def self.down
  end
end
