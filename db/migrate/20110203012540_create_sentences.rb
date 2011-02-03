class CreateSentences < ActiveRecord::Migration
  def self.up
    create_table :sentences do |t|
      t.integer :language_code
      t.text    :text
      t.integer :translation_pairs_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :sentences
  end
end
