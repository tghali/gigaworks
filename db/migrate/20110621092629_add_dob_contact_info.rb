class AddDobContactInfo < ActiveRecord::Migration
  def self.up
	  add_column :contact_informations, :dob, :date
	  add_column :contact_informations, :qualification, :string
	  add_column :contact_informations, :department, :string
  end

  def self.down
	  remove_column :contact_informations, :dob
	  remove_column :contact_informations, :qualification
	  remove_column :contact_informations, :department
  end
end
