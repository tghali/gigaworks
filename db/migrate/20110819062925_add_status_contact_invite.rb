class AddStatusContactInvite < ActiveRecord::Migration
  def self.up
	  add_column :client_contact_invites,:status,:integer,:default => 0
  end

  def self.down
	  remove_column :client_contact_invites,:status
  end
end
