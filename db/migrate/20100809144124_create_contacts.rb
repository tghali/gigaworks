class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.integer :organization_id
      t.string :title
      t.integer :timezone_code
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
