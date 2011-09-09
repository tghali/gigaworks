class CreateFrontendPages < ActiveRecord::Migration
  def self.up
    create_table :frontend_pages do |t|
      t.integer :user_id
      t.text   :title
      t.text   :content 
      t.string   :page_section
      t.text   :news
      t.text   :network
      t.text   :contact_us
      t.string  :image_content_type
      t.string  :image_file_name
      t.string  :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :frontend_pages
  end
end
