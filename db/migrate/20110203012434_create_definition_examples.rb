class CreateDefinitionExamples < ActiveRecord::Migration
  def self.up
    create_table :definition_examples do |t|
      t.integer :definition_id
      t.integer :sentence_id

      t.timestamps
    end
  end

  def self.down
    drop_table :definition_examples
  end
end
