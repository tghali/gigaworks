class CreateAccountMemberships < ActiveRecord::Migration
  def self.up
    create_table :account_memberships do |t|
      t.integer :account_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :account_memberships
  end
end
