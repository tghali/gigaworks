class CreateGigaclients < ActiveRecord::Migration
  def self.up
    create_table :gigaclients do |t|

      t.string :title
      t.string  :first_name
      t.string  :middle_name
      t.string :last_name    
      t.string :suffix    
	t.string :email  
	t.string :email2
t.string :business_street    
t.string :business_street2  
t.string :business_city    
t.string :business_state    
t.string :business_postal_code    
t.string :business_country    
t.string :home_street    
t.string :home_street2    

t.string :home_city    
t.string :home_state    
t.string :home_postal_code    
t.string :home_country    


t.string :company
t.string :business_fax       
t.string :business_phone    
t.string :business_phone2    
t.string :home_fax
t.string :home_phone

#~ Home Phone 2    ISDN    
t.string :mobile_phone           
t.string :pager    
t.string :primary_phone    
t.string :notes    
t.string :web_page
t.timestamps
    end
  end

  def self.down
    drop_table :gigaclients
  end
end
