class ChangeColumnResume < ActiveRecord::Migration
  def self.up
	change_column :talents, :resume, :string, :null => true
	change_column :talents, :project_experience, :string, :null => true
  end

  def self.down
	change_column :talents, :resume, :string, :null => false
	change_column :talents, :project_experience, :string, :null => false
  end
end
