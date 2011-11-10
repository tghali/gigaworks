class CreateClientcreditDetails < ActiveRecord::Migration
  def self.up
    create_table :clientcredit_details do |t|
	t.references :gigaclient
	t.string :credit_number
	t.integer :expires_on_month
	t.integer :expires_on_year
	t.integer :verification_number
	t.string :card_type
 	t.integer :biling_zip

      t.timestamps
    end
  end

  def self.down
    drop_table :clientcredit_details
  end
end
