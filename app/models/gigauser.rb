require 'digest/sha1'

class Gigauser < ActiveRecord::Base
	  acts_as_paranoid
    validates_as_paranoid
    
	  validates :username,
    :presence => true
    validates_uniqueness_of_without_deleted  :username
    #:uniqueness => {:if => :username?}    
  #validates :password,:password_confirmation,
  #  :presence => true  
	
  attr_accessor :password, :password_confirmation,:terms_of_service, :privacy_policy

  validates_presence_of        :password, :on => :update, :unless => :password_changed?
  validates_confirmation_of  :password, :if => :password_changed?
  validates_length_of        :password, :within => 7..30, :if => :password_changed?	

  #~ validates_acceptance_of    :terms_of_service, :on => :update
  #~ validates_acceptance_of    :privacy_policy, :on => :update

  validates_presence_of  :first_name,:last_name,:email , :on => :create, :if => Proc.new {|user| user.main_account_id != nil}
  
  #validates_acceptance_of    :terms_of_service, :on => :update, :if => Proc.new {|user| user.main_account_id == nil}
  #validates_acceptance_of    :privacy_policy, :on => :update, :if => Proc.new {|user| user.main_account_id == nil}
  
  #validates_acceptance_of    :terms_of_service, :on => :create, :if => Proc.new {|user| user.main_account_id != nil}
  #validates_acceptance_of    :privacy_policy, :on => :create, :if => Proc.new {|user| user.main_account_id != nil}
	  
 ## Password

  def self.authenticate(username_or_email, password)
    if username_or_email
      user = Gigauser.find_by_username(username_or_email)
    end
    expected_password = encrypted_password(password, user.salt) 
    user.hashed_password == expected_password or raise ActiveRecord::RecordNotFound
    
    return user
  rescue ActiveRecord::RecordNotFound
    nil
  end
  
  # Virtual attribute to access the clear password for validations
   def self.authenticate(username_or_email, password)
    if username_or_email
      user = Gigauser.find_by_username(username_or_email)
    end
    expected_password = encrypted_password(password, user.salt) 
    puts expected_password
    user.hashed_password == expected_password or raise ActiveRecord::RecordNotFound
    
    return user
  rescue ActiveRecord::RecordNotFound
    nil
  end



  #Initiates the password reset procedure
  # @param [String] email the email address is looked up in the users database to reset the user’s password.
  # @return [User] The user, eventually with the errors raised by the password reset procedure.
  def self.forgot_password_for(email,username)
    user = self.find(:first,:conditions => ["email = '#{email}' and username = '#{username}'"]) 
    user
  end

  def self.authenticate_from_session(id, cookie_salt, session_expires_at = nil)
    user = find_by_id(id) || Gigauser.find_by_id(id)    
    #~ user = Gigauser.find_by_id(id)  
    user && (user.salt == cookie_salt) or return nil
    if session_expires_at && session_expires_at < Time.now
      raise 'session expired by stamp'
      return nil
    end
    
    return user
  end
    def self.make_token
      string_to_hash = "#{Time.now}-#{rand}"
      token = Digest::SHA1.hexdigest(string_to_hash)
      token
    end
  
  def self.find_by_password_reset_token(token)
    key = UserPasswordResetKey.find_by_token(token) or raise ActiveRecord::RecordNotFound
    key.user.password_reset_token = token
    return key.user
  end

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
    self.hashed_password = Gigauser.encrypted_password(self.password, self.salt) 

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
