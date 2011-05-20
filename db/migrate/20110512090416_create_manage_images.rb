class CreateManageImages < ActiveRecord::Migration
  def self.up
    create_table :manage_images do |t|
      t.integer :author_id
      t.string  :subject
      t.string  :tags     
      t.string :description
      t.string :image_content_type
      t.string :image_file_name
      t.string :image_file_size
      t.datetime :image_updated_at      
      t.timestamps
    end
  end

  def self.down
    drop_table :manage_images
  end
end
