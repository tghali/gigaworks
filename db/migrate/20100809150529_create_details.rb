class CreateDetails < ActiveRecord::Migration
  def self.up
    create_table :details do |t|
      t.integer :contact_id
      t.integer :property_code
      t.integer :type_code
      t.boolean :pref
      t.string  :value
      t.integer :extra_property_index
      t.string  :extra_property_label

      t.timestamps
    end
  end

  def self.down
    drop_table :details
  end
end
