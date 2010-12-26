class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string  :first_name
      t.string  :last_name
      t.integer :organization_id
      t.string  :title
      t.integer :timezone_code
      t.integer :email_type_code,     :default => 0
      t.string  :email
      t.integer :telephone_type_code, :default => 0
      t.string  :telephone
      t.boolean :public,              :default => true
      t.string  :note
      t.date    :birthday
      t.string  :role

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
