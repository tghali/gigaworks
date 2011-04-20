class CreateGlossaryActions < ActiveRecord::Migration
  def self.up
    create_table :glossary_actions do |t|
      t.integer :glossary_id
      t.integer :user_id
      t.integer :target_id
      t.string  :target_type
      t.string  :action

      t.timestamps
    end
  end

  def self.down
    drop_table :glossary_actions
  end
end
