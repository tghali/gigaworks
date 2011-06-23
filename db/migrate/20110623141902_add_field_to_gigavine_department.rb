class AddFieldToGigavineDepartment < ActiveRecord::Migration
  def self.up
    add_column :gigavine_departments, :department_id, :integer
  end

  def self.down
    remove_column :gigavine_departments, :department_id
  end
end
