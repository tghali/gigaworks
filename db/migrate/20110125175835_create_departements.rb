class CreateDepartements < ActiveRecord::Migration
  def self.up
    create_table :departements do |t|
      t.integer :name_code
      t.boolean :active, :default => true
      t.integer :user_id
      t.string  :role

      t.timestamps
    end
  end

  def self.down
    drop_table :departements
  end
end
