class CreateDefinitions < ActiveRecord::Migration
  def self.up
    create_table :definitions do |t|
      t.integer :word_id
      t.integer :translator_id
      t.integer :kind_code
      t.text    :description
      t.integer :occurrences_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :definitions
  end
end
