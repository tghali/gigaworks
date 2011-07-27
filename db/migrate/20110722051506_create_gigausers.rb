class CreateGigausers < ActiveRecord::Migration
  def self.up
    create_table :gigausers do |t|
      t.string   :username,         :null => false, :default => "", :limit => 32
      t.string   :email,            :null => false, :default => "", :limit => 64
      t.string   :first_name,       :limit => 32
      t.string   :last_name,        :limit => 32
      t.string   :title,            :limit => 64
      t.string   :organization,          :limit => 64
      t.string   :alt_email,        :limit => 64
      t.string   :phone,            :limit => 32
      t.string   :mobile,           :limit => 32
      t.string   :hashed_password
      t.string   :salt
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string   :last_login_ip
      t.string   :current_login_ip
      t.integer  :login_count,      :null => false, :default => 0
      t.integer :gigaclient_id
      t.integer :role_id
      t.timestamps
    end
  end

  def self.down
    drop_table :gigausers
  end
end
