class Contact < ActiveRecord::Base
  ## ahmed mohamed changes
   EMAILS = [
    ['General', 'info@gigavine.com'],
    ['Sales',   'sales@gigavine.com'],
    ['Feedback', 'feedback@gigavine.com']
  ]

  TOS = EMAILS.collect { |e| e.first }

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  #~ attr_accessor :name, :email, :message, :to, :requerst_call

  #~ validates :name,  :presence  => true
  ### validates :email, :format    => { :with  => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i }
  #~ validates :to,    :inclusion => { :in    => TOS }
  
  #### end of changes
  
  
  
  
  has_one    :user, :dependent => :destroy
  has_one    :invite, :foreign_key => 'recipient_id', :dependent => :destroy
  
  belongs_to :organisation
  has_many   :details
  has_many   :addresses
  
  has_one_baked_in :email_type,     :names => Gigavine::Preferences.contact_detail_types
  has_one_baked_in :telephone_type, :names => Gigavine::Preferences.contact_detail_types
  
  # scope :shared, where(:public => true)
  scope :shared, where(:organisation_id => 1)
  
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
  
  
  ########## methods of ahmed mohamed ################
  #~ def initialize(attributes = {})
    #~ attributes.each do |name, value|
      #~ send("#{name}=", value)
    #~ end
  #~ end

  #~ def request_call?
    #~ requerst_call == '1'
  #~ end
  
  #~ def email_to
    #~ EMAILS.select{ |e| e.first == to }.first.last
  #~ end

  #~ def persisted?
    #~ false
  #~ end
  ############ end #############
  
  
 
end
