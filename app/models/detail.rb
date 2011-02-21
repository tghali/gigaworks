class Detail < ActiveRecord::Base
  has_one_baked_in :property, :names => [:TEL, :EMAIL, :URL] # :ADR - this is for contact address
  has_one_baked_in :type,     :names => Gigavine::Preferences.contact_detail_types
  
  
  
  def self.emails
    where(:property_code => Detail::PROPERTIES.index(:EMAIL))
  end
  
  def self.telephones
    where(:property_code => Detail::PROPERTIES.index(:TEL))
  end
  
  def self.url
    where(:property_code => Detail::PROPERTIES.index(:URL))
  end
end
