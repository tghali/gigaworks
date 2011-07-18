class CreateBriefDetails < ActiveRecord::Migration
  def self.up
    create_table :brief_details do |t|
      t.string :name 
      t.string :email 
      t.string :attachment_content_type 
      t.string :attachment_file_name 
      t.string :attachment_file_size 
      t.date :attachment_updated_at 
      t.timestamps
    end
  end

  def self.down
    drop_table :brief_details
  end
end
