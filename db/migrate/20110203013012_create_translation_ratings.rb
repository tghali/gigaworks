class CreateTranslationRatings < ActiveRecord::Migration
  def self.up
    create_table :translation_ratings do |t|
      t.integer :translation_id
      t.integer :translator_id
      t.integer :vote
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :translation_ratings
  end
end
