class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :first_name
      t.string :last_name
      t.string  :name
      t.integer :author_id
      t.string  :document_content_type
      t.string :document_file_name
      t.string :document_file_size
      t.datetime :document_updated_at
      t.integer :source_document_id
      t.text    :description
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
