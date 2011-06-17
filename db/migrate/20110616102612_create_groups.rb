class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.integer :author_id
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
