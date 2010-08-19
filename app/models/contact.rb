class Contact < ActiveRecord::Base
  
  has_one    :user
  belongs_to :organization
  
  
  validates_uniqueness_of    :email, :if => :email_changed?
  validates_presence_of      :first_name, :last_name
  
  validates_format_of        :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  accepts_nested_attributes_for :organization
  
  attr_accessible :first_name, :last_name, :organization_attributes, :title,
                  :timezone_code, :email, :telephone, :organization
 
end
