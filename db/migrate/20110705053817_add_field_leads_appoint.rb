class AddFieldLeadsAppoint < ActiveRecord::Migration
  def self.up
	  add_column :leads, :appointed_to,:string
  end

  def self.down
	  	  remove_column :leads, :appointed_to
 
  end
end
