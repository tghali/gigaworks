class AddClientFields < ActiveRecord::Migration
  def self.up

	  remove_column :gigaclients,:suffix
	  remove_column :gigaclients,:email2
	  remove_column :gigaclients,:business_street
	  remove_column :gigaclients,:business_street2
	  remove_column :gigaclients,:business_city
	  remove_column :gigaclients,:business_state
	  remove_column :gigaclients,:business_postal_code
	  remove_column :gigaclients,:business_country
	  remove_column :gigaclients,:home_street
	  remove_column :gigaclients,:home_street2
	  remove_column :gigaclients,:home_city
	  remove_column :gigaclients,:home_state
	  remove_column :gigaclients,:home_postal_code
	  remove_column :gigaclients,:home_country
	  remove_column :gigaclients,:business_fax
	  remove_column :gigaclients,:business_phone
	  remove_column :gigaclients,:business_phone2
	  remove_column :gigaclients,:home_fax
	  remove_column :gigaclients,:home_phone
	  remove_column :gigaclients,:mobile_phone
	  remove_column :gigaclients,:pager
	  remove_column :gigaclients,:primary_phone
	  remove_column :gigaclients,:notes
 	  
	  
	  ##add columns
	  add_column :gigaclients,:status,:boolean
	  
  end

  def self.down

	  add_column :gigaclients,:suffix,:string
	  add_column :gigaclients,:email2,:string
	  add_column :gigaclients,:business_street,:string
	  add_column :gigaclients,:business_street2,:string
	  add_column :gigaclients,:business_city,:string
	  add_column :gigaclients,:business_state,:string
	  add_column :gigaclients,:business_postal_code,:string
	  add_column :gigaclients,:business_country,:string
	  add_column :gigaclients,:home_street,:string
	  add_column :gigaclients,:home_street2,:string
	  add_column :gigaclients,:home_city,:string
	  add_column :gigaclients,:home_state,:string
	  add_column :gigaclients,:home_postal_code,:string
	  add_column :gigaclients,:home_country,:string
	  add_column :gigaclients,:business_fax,:string
	  add_column :gigaclients,:business_phone,:string
	  add_column :gigaclients,:business_phone2,:string
	  add_column :gigaclients,:home_fax,:string
	  add_column :gigaclients,:home_phone,:string
	  add_column :gigaclients,:mobile_phone,:string
	  add_column :gigaclients,:pager,:string
	  add_column :gigaclients,:primary_phone,:string
	  add_column :gigaclients,:notes,:string
 	  
	  
	  ##add columns
	  remove_column :gigaclients,:status 
	  
  end
end
