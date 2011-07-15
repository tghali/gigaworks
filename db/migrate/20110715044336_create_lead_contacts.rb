class CreateLeadContacts < ActiveRecord::Migration
  def self.up
    create_table :lead_contacts do |t|
      t.integer :lead_id
      t.string :first_name_1
      t.string :last_name_1
      t.string :email_1
      t.string :phone_1
      t.string :job_title_1
      t.string :desicion_maker_1      
      t.string :first_name_2
      t.string :last_name_2
      t.string :email_2
      t.string :phone_2
      t.string :job_title_2
      t.string :desicion_maker_2    
      t.timestamps
    end
  end

  def self.down
    drop_table :lead_contacts
  end
end
