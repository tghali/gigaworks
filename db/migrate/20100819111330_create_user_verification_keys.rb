class CreateUserVerificationKeys < ActiveRecord::Migration
  def self.up
    create_table :user_verification_keys do |t|
      t.integer :user_id
      t.string :token
      t.string :request_ip
      t.datetime :sent_at
      t.boolean :password_reset

      t.timestamps
    end
  end

  def self.down
    drop_table :user_verification_keys
  end
end
