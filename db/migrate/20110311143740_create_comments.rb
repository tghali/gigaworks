class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string  :title
      t.integer :author_id
      t.integer :commentable_id
      t.string  :commentable_type
      t.text    :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
