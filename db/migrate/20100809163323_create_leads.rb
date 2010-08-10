class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.integer  :referent_id
      t.integer  :organization_id
      t.integer  :status_code

      t.timestamps
    end
  end

  def self.down
    drop_table :leads
  end
end
