class Detail < ActiveRecord::Base
  has_one_baked_in :property, :names => [:TEL, :EMAIL, :URL, :ADR]
  has_one_baked_in :type,     :names => Gigavine::Preferences.contact_detail_types
  
  
end
