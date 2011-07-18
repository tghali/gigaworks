class CreateBriefDetails < ActiveRecord::Migration
  def self.up
    create_table :brief_details do |t|
      t.string :name,  :string
      t.string :email,  :string
      t.string :attachment_content_type,  :string
      t.string :attachment_file_name,  :string
      t.string :attachment_file_size,  :string
      t.string :attachment_updated_at,  :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :brief_details
  end
end
