class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :token
      t.datetime :sent_at

      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
