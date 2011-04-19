class AddPlaceholderToGlossaryActions < ActiveRecord::Migration
  def self.up
    add_column :glossary_actions, :placeholder, :string
  end

  def self.down
    remove_column :glossary_actions, :placeholder
  end
end
