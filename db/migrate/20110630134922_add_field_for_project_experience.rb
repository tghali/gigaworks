class AddFieldForProjectExperience < ActiveRecord::Migration
  def self.up
	  add_column :talents, :project_experience,:string
	  add_column :talents, :resume,:string
  end

  def self.down
	  remove_column :talents, :project_experience
	  remove_column :talents, :resume
  end
end
