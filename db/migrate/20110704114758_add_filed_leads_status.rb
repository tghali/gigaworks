class AddFiledLeadsStatus < ActiveRecord::Migration
  def self.up
	  remove_column :leads,:status
	  add_column :leads,:status, :string, :dafault=>"Lead"
  end

  def self.down
	  add_column :leads,:status
	  remove_column :leads,:status 
  end
end
