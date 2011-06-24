class CreateClientAddresses < ActiveRecord::Migration
  def self.up
    create_table :client_addresses do |t|
	t.string :first_line    
	t.string :second_line  
	t.string :city    
	t.string :state    
	t.string :zipcode    
	t.string :country    
	t.string :po_box    
	t.string :phone    
	t.string :mobile    
	t.string :title
       t.timestamps
    end
  end

  def self.down
    drop_table :client_addresses
  end
end
