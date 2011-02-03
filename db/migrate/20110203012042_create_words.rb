class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.string  :word
      t.string  :origin
      t.string  :pronunciation
      t.integer :language_code

      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end
end
