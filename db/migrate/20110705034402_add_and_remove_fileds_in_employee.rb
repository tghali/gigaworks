class AddAndRemoveFiledsInEmployee < ActiveRecord::Migration
  def self.up
	  remove_column :employs,:job_title
	  add_column :employs,:position, :string
	  add_column :employs,:status, :smallint
	  add_column :employs,:phone, :smallint
  end

  def self.down
	  add_column :employs,:job_title
	  remove_column :employs,:position
	  remove_column :employs,:status
	  remove_column :employs,:phone
  end
end
