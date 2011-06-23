class CreateGigavineDepartments < ActiveRecord::Migration
  def self.up
    create_table :gigavine_departments do |t|
     t.string :name
     t.string :description
     t.smallint :status,:default => 1
     t.integer :author_id

      t.timestamps
    end
  end

  def self.down
    drop_table :gigavine_departments
  end
end
