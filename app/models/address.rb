class Address < ActiveRecord::Base
  
  belongs_to :contact
  has_one_baked_in :address_type, :names => Gigavine::Preferences.contact_detail_types
  
end
