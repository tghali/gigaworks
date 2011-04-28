class CreateSourceDocuments < ActiveRecord::Migration
  def self.up
    create_table :source_documents do |t|
      t.string  :name
      t.integer :author_id
      t.string :description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :source_documents
  end
end
