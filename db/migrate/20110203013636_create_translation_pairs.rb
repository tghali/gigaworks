class CreateTranslationPairs < ActiveRecord::Migration
  def self.up
    create_table :translation_pairs do |t|
      t.integer :sentence_id
      t.integer :language_code
      t.text    :text
      t.integer :translator_id
      t.integer :status_code, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :translation_pairs
  end
end
