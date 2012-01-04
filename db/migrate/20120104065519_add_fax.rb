class AddFax < ActiveRecord::Migration
  def self.up
  add_column :client_addresses, :fax, :string
  end

  def self.down
  remove_column :client_addresses, :fax
  end
end
