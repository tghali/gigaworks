class AddLeadFieldsForComapny < ActiveRecord::Migration
  def self.up
	  add_column :leads,:company,:string
	  add_column :leads,:title,:string
  end

  def self.down
	  remove_column :leads,:company 
	  remove_column :leads,:title 
  end
end
