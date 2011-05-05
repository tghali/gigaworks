class AddFieldsSourceDocuments < ActiveRecord::Migration
  def self.up
    add_column :source_documents, :translation, :smallint
    add_column :source_documents, :QA, :smallint
    add_column :source_documents, :design, :smallint
    add_column :source_documents, :localisation, :smallint
    add_column :source_documents, :target_language, :string
    add_column :source_documents, :deadline_date, :datetime
    add_column :source_documents, :request_quote, :smallint
  end

  def self.down
    remove_column :source_documents, :translation
    remove_column :source_documents, :QA
    remove_column :source_documents, :design
    remove_column :source_documents, :localisation
    remove_column :source_documents, :target_language
    remove_column :source_documents, :deadline_date
    remove_column :source_documents, :request_quote
  end
end
