class CreateGigadomains < ActiveRecord::Migration
  def self.up
    create_table :gigadomains do |t|
      t.string :subdomain
      t.integer :owner_id
      t.timestamps
    end
  end

  def self.down
    drop_table :gigadomains
  end
end
