class AddToken < ActiveRecord::Migration
  def self.up
  add_column :gigausers, :token, :string
  end

  def self.down
  remove_column :gigausers, :token
  end
end
