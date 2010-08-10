class CreateDetails < ActiveRecord::Migration
  def self.up
    create_table :details do |t|
      t.integer :contact_id
      t.integer :property_code
      t.string :value
      t.integer :type_mask
      t.integer :extra_property_code
      t.string :extra_property_value

      t.timestamps
    end
  end

  def self.down
    drop_table :details
  end
end
