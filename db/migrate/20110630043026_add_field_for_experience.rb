class AddFieldForExperience < ActiveRecord::Migration
  def self.up
	  	  add_column :talents, :years_of_experiene,:string
	  add_column :talents, :months_of_experiene,:integer
  end

  def self.down
	  	  remove_column :talents, :years_of_experiene
	  remove_column :talents, :months_of_experiene
  end
end
