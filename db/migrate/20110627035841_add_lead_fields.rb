class AddLeadFields < ActiveRecord::Migration
  def self.up
	  add_column :leads,:first_name,:string
	  add_column :leads,:last_name,:string
	  add_column :leads,:pms_url,:string
	  add_column :leads,:fax,:string
	  add_column :leads,:email,:string
	  add_column :leads,:web_url,:string
	  add_column :leads,:industry,:string
	  add_column :leads,:turnover,:string
	  add_column :leads,:notes,:string
	  add_column :leads,:first_line,:string
	  add_column :leads,:second_line,:string
	  add_column :leads,:city,:string
	  add_column :leads,:state,:string
	  add_column :leads,:zipcode,:string
	  add_column :leads,:country,:string
	  add_column :leads,:po_box,:string
	  add_column :leads,:phone,:string
	  add_column :leads,:mobile,:string
	  add_column :leads,:status,:smallint
	  
 
  end

  def self.down
	  remove_column :leads,:first_name,:string
	  remove_column :leads,:last_name,:string
	  remove_column :leads,:email,:string
	  remove_column :leads,:pms_url,:string
	  remove_column :leads,:fax,:string
	  remove_column :leads,:web_url,:string
	  remove_column :leads,:industry,:string
	  remove_column :leads,:turnover,:string
	  remove_column :leads,:notes,:string
	  remove_column :leads,:first_line,:string
	  remove_column :leads,:second_line,:string
	  remove_column :leads,:city,:string
	  remove_column :leads,:state,:string
	  remove_column :leads,:zipcode,:string
	  remove_column :leads,:country,:string
	  remove_column :leads,:po_box,:string
	  remove_column :leads,:phone,:string
	  remove_column :leads,:mobile,:string
	  remove_column :leads,:status,:smallint
  end
end
