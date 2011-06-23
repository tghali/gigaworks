class CreateEmploys < ActiveRecord::Migration
  def self.up
    create_table :employs do |t|
   
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile
      t.string :department_id
      t.string :job_title
      t.string :tax_id
      t.string :salary
      t.date :dob
      t.date :date_of_join
      t.string :passport
      t.string :reports_to
      t.integer :author_id
      t.string :passport_content_type
      t.string  :passport_file_name
     t.string  :passport_file_size
     t.datetime :passport_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :employs
  end
end
