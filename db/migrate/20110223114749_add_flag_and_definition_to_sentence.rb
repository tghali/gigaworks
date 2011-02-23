class AddFlagAndDefinitionToSentence < ActiveRecord::Migration
  def self.up
    add_column :sentences, :definition,    :string
    add_column :sentences, :flagged_by_id, :integer
  end

  def self.down
    remove_column :sentences, :definition
    remove_column :sentences, :flagged_by_id
  end
end