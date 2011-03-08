class Contact < ActiveRecord::Base
  
  has_one    :user
  has_one    :invite, :foreign_key => 'recipient_id', :dependent => :destroy
  
  belongs_to :organisation
  has_many   :details
  has_many   :addresses
  
  has_one_baked_in :email_type,     :names => Gigavine::Preferences.contact_detail_types
  has_one_baked_in :telephone_type, :names => Gigavine::Preferences.contact_detail_types
  
  scope :shared, where(:public => true)
  
  validates_uniqueness_of    :email, :if => :email_changed?
  validates_presence_of      :first_name, :last_name
  
  validates_format_of        :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  accepts_nested_attributes_for :addresses, :allow_destroy => true, :reject_if => proc { |obj| obj[:first_line].blank?  }
  
  attr_accessible :first_name, :last_name, :organisation_attributes, :title,
                  :timezone_code, :email, :telephone, :organisation
 
 
 def full_name
   if title
     "#{title} #{first_name} #{last_name}"
   else
    "#{first_name} #{last_name}"
   end
 end
 
 def first_with_title= (first_name_and_title)
   self.first_name = first_name_and_title.first
   self.title      = first_name_and_title.second
 end

 
 def organisation_name= organisation_name
  o = Organisation.find_or_create_by_name organisation_name
  self.organisation = o
 end
 
 def organisation_name
    self.organisation ? self.organisation.name : ''
 end
 
end
