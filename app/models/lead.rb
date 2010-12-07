class Lead < ActiveRecord::Base
  
  has_one_baked_in  :status, :names => [:acquired, :assigned, :password_reset, :deleted, :suspended, :banned],
                             :groups => {:active =>     [:verified, :password_reset],
                                         :visible =>    [:unverified, :verified, :password_reset, :suspended],
                                         :inactive =>   [:deleted, :suspended, :banned],
                                         :unverified => [:unverified]}
  
  belongs_to :organization
  belongs_to :contact, :class_name => "Contact"
  
  belongs_to :sales # the sales operator's profile
  
  has_many :activities, :class_name => "SalesActivity"
  
  # belongs_to :source # Make it polymorphic
  
  #TODO wirite a class method for the contact importer that creates new leads or marks the duplicates
  #     as such in the activity stream.
  def self.import(contact)
    
  end
  
end
