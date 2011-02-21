class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :contact_id
      t.string  :first_line
      t.string  :second_line
      t.string  :state_or_province
      t.string  :postcode
      t.string  :country
      t.integer :type_code, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
