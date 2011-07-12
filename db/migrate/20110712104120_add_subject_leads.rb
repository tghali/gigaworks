class AddSubjectLeads < ActiveRecord::Migration
  def self.up
	  add_column :leads, :subject,:string
  end

  def self.down
	  remove_column :leads, :subject
  end
end
