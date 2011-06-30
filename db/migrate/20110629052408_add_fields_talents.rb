class AddFieldsTalents < ActiveRecord::Migration
  def self.up
	  add_column :talents,:language_id,:integer
	  add_column :talents,:skill_id,:integer
	  add_column :talents,:years_of_experience,:date
	  add_column :talents,:current_location,:string
	  add_column :talents,:mobile,:string
	  add_column :talents,:phone,:string
	  add_column :talents,:graduation,:string
	  add_column :talents,:post_graduation,:string
	  add_column :talents,:doctrate,:string
	  add_column :talents,:date_of_birth,:date
	  add_column :talents,:rate,:string
	  add_column :talents,:rating,:string
	  add_column :talents,:previous_client,:string
	  add_column :talents,:from,:date
	  add_column :talents,:to,:date
	  
 
  end

  def self.down
	  
	  remove_column :talents,:language_id,:integer
	  remove_column :talents,:skill_id,:integer
	  remove_column :talents,:years_of_experience,:date
	  remove_column :talents,:current_location,:string
	  remove_column :talents,:mobile,:string
	  remove_column :talents,:phone,:string
	  remove_column :talents,:graduation,:string
	  remove_column :talents,:post_graduation,:string
	  remove_column :talents,:doctrate,:string
	  remove_column :talents,:date_of_birth,:date
	  remove_column :talents,:rate,:string
	  remove_column :talents,:rating,:string
	  remove_column :talents,:previous_client,:string
	  remove_column :talents,:from,:date
	  remove_column :talents,:to,:date
	  
	  
	  
  end
end
