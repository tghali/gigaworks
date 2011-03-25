class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :author_id
      t.integer :taggable_id
      t.string  :taggable_type
      t.integer :realm_id
      t.text    :tag

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end