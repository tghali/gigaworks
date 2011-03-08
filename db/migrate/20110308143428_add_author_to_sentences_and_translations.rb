class AddAuthorToSentencesAndTranslations < ActiveRecord::Migration
  def self.up
    add_column :sentences,         :author_id, :integer
    add_column :translation_pairs, :author_id, :integer
  end

  def self.down
    remove_column :sentences,         :author_id
    remove_column :translation_pairs, :author_id
  end
end
