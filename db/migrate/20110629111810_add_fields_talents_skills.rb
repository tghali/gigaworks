class AddFieldsTalentsSkills < ActiveRecord::Migration
  def self.up
	  add_column :skills, :years_of_experiene,:string
	  add_column :skills, :months_of_experiene,:integer
	  add_column :skills, :project_experience,:integer
	  add_column :skills, :resume,:integer
	  
	  
  end

  def self.down
	  remove_column :skills, :years_of_experiene
	  remove_column :skills, :months_of_experiene
	  remove_column :skills, :resume
  end
end
