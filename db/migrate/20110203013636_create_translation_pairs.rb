class CreateTranslationPairs < ActiveRecord::Migration
  def self.up
    create_table :translation_pairs do |t|
      t.integer :source_id
      t.integer :result_id
      t.integer :translator_id
      t.integer :status_code

      t.timestamps
    end
  end

  def self.down
    drop_table :translation_pairs
  end
end
