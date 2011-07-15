class AddEmpCountLead < ActiveRecord::Migration
  def self.up
	  add_column :leads,:emp_count,:string
  end

  def self.down
	  remove_column :leads,:emp_count
  end
end
