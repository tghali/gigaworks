class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.integer   :sales_id
      t.integer   :contact_id
      t.integer   :source_id
      t.string    :source_type
      t.integer   :organisation_id
      t.integer   :status_code

      t.timestamps
    end
  end

  def self.down
    drop_table :leads
  end
end
