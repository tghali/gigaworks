class CreateClientContacts < ActiveRecord::Migration
  def self.up
    create_table :client_contacts do |t|
      t.string   :email,            :null => false, :default => "", :limit => 64
      t.string   :first_name,       :limit => 32
      t.string   :last_name,        :limit => 32
      t.string   :title,            :limit => 64
      t.string   :organization,          :limit => 64
      t.integer   :gender 
      t.string   :role
      t.integer :gigaclient_id
      t.timestamps
    end
  end

  def self.down
    drop_table :client_contacts
  end
end
