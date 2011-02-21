class AddUserDefaults < ActiveRecord::Migration
  def self.up
    change_column_default(:users, :status_code, 0)
    change_column_default(:users, :roles_mask, 0)
  end

  def self.down
    change_column_default(:users, :status_code, nil)
    change_column_default(:users, :roles_mask, nil)
  end
end
