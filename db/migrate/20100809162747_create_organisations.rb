class CreateOrganisations < ActiveRecord::Migration
  def self.up
    create_table :organisations do |t|
      t.string  :name
      t.string :country_code

      t.timestamps
    end
  end

  def self.down
    drop_table :organisations
  end
end
