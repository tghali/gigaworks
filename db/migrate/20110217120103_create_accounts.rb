class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :organisation_id
      t.integer :sales_representative_id
      t.integer :status_code, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
