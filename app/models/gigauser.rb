require 'digest/sha1'

class Gigauser < ActiveRecord::Base
	
	  validates :username,
    :presence => true,
    :uniqueness => {:if => :username?}    
  validates :password,:password_confirmation,
    :presence => true  
	
  attr_accessor :password, :password_confirmation,:terms_of_service, :privacy_policy

  validates_presence_of        :password, :on => :update, :unless => :password_changed?
  validates_confirmation_of  :password, :if => :password_changed?
  validates_length_of        :password, :within => 7..30, :if => :password_changed?	

  #~ validates_acceptance_of    :terms_of_service, :on => :update
  #~ validates_acceptance_of    :privacy_policy, :on => :update

  validates_presence_of  :first_name,:last_name,:email , :on => :create, :if => Proc.new {|user| user.main_account_id != nil}
  
  validates_acceptance_of    :terms_of_service, :on => :update, :if => Proc.new {|user| user.main_account_id == nil}
  validates_acceptance_of    :privacy_policy, :on => :update, :if => Proc.new {|user| user.main_account_id == nil}
  
  validates_acceptance_of    :terms_of_service, :on => :create, :if => Proc.new {|user| user.main_account_id != nil}
  validates_acceptance_of    :privacy_policy, :on => :create, :if => Proc.new {|user| user.main_account_id != nil}
	  
 ## Password
  
  # Virtual attribute to access the clear password for validations
  def password 
    @password
  end 
  
  # Returns true or false if a new password has been set.
  def password_changed?
    @password ? true : false
  end
  
  # Sets the clear password and creates the hashed one, If the password field is blank
  # the password isn't changed.
  def password=(pwd)
    return if pwd.blank?
    @password = pwd 
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt) 
  end	
	  private 
    
    # Returns the password, hashed with the provided salt
    def self.encrypted_password(password, salt) 
    string_to_hash = password + 'giga-funkyness' + salt 
      Digest::SHA1.hexdigest(string_to_hash) 
    end 
    
    # Creates a salt and stores it in the user model
    def create_new_salt
      self.salt = (self.object_id + rand(self.object_id)).to_s(36)
    end
end
