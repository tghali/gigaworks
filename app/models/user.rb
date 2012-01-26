require 'digest/sha1'

module UserErrors
  class Base < Exception; end
  class NotActive < UserErrors::Base; end
end

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  belongs_to :contact
  
  has_one_baked_in  :status, :names => [:unverified, :verified, :password_reset, :suspended, :banned],
                             :groups => {:active =>     [:verified, :password_reset],
                                         :visible =>    [:unverified, :verified, :password_reset, :suspended],
                                         :inactive =>   [:suspended, :banned],
                                         :unverified => [:unverified]}
  
  has_many_baked_in :roles, :names => [:admin],
                            :verb => :is
  
  has_attached_file :avatar,        
                    :storage        => :s3,
                    :path           => ":attachment/:id/:style.:extension",
                    :default_url   => "/images/:attachment/:style-missing.png",
                    :s3_credentials => { :access_key_id     => ENV['S3_KEY'],
                                         :secret_access_key => ENV['S3_SECRET']},
                    :bucket         => ENV['S3_BUCKET'],
                    :styles         => { :medium => "128x128>",
                                         :small  => "48x48>"}
  
  has_many :comments
  has_many :glossary_actions
  
  has_many :departements do
    
    def add departement_name
      create! :name => departement_name
    end
    
    def remove departement_name
      departement = Departement.where(:name_code => Departement::NAMES.index(departement_name), :user_id => proxy_owner.id).first
      
      departement.delete if departement
    end
    
    def list
      @departements_list ||= map(&:name)
    end
    
    def has? departement_name
      list.include? departement_name
    end
    
  end
  
  has_one :languages, :class_name => 'Departements::Languages'
  has_one :sales,     :class_name => 'Departements::Sales'
  
  # Client Profile
  has_one :account_membership
  
  has_one :account, :through => :account_membership
  
  
  
  scope :with_role,
        lambda { |role| where("roles_mask & #{2**ROLES.index(role.to_sym)} > 0") }
  scope :active,     where(status_condition(:active))
  scope :inactive,   where(status_condition(:inactive))
  scope :unverified, where(status_condition(:unverified))
  
  
  # INVITES AND VERIFICATION
  has_many   :invites, :foreign_key => 'sender_id', :dependent => :destroy
  
  has_one    :verification_key,   :class_name => 'UserVerificationKey',
                                  :dependent => :destroy, :autosave => true,
                                  :conditions => { :password_reset => false}
  has_one    :password_reset_key, :class_name => 'UserPasswordResetKey',
                                  :dependent => :destroy, :autosave => true,
                                  :conditions => { :password_reset => true}
  
  # DELEGATES
  delegate :email, :to => :contact
  
  # REGISTRATION AND UPDATE                             
  validates_presence_of      :contact
  validates_uniqueness_of    :contact_id
  validates_associated       :contact
  validates_acceptance_of    :terms_of_service, :on => :create
  validates_acceptance_of    :privacy_policy, :on => :create
  
  validates_inclusion_of     :status_code, :on => :update,
                                           :in => status_codes_for(:active),
                                           :unless => :performed_by_admin?,
                                           :message => :not_verified
                             
  validate                   :reset_token_or_old_password, :if => :password_changed?,
                                                           :on => :update,
                                                           :unless => :performed_by_admin?
  
  validates_presence_of        :password, :on => :create, :unless => :password_changed?
  
  
  validates_confirmation_of  :password, :if => :password_changed?
  validates_length_of        :password, :within => 7..30, :if => :password_changed?
                             
  validates_associated       :verification_key, :message => :expired
  validates_associated       :password_reset_key, :message => :expired

  before_update     :spend_user_token, :if => lambda {|u| u.status_code_changed? && u.verified?}
  before_create     :create_verification_key, :unless => :verified?
  before_save       :delete_clear_password
  
  accepts_nested_attributes_for :contact
  
  attr_accessible :user_name, :password, :password_confirmation, :contact_attributes,
                  :old_password, :password_reset_token, :avatar, :contact, :invite_token,
                  :terms_of_service, :privacy_policy
  
  attr_accessor   :old_password, :password_reset_token, :password_confirmation,
                  :terms_of_service, :privacy_policy, :session_expires_at
  
  
  # Project Management and Administration
  
  # Checks if the user has a client account
  def is_client?
    self.account_membership != nil
  end
  
  # Finds Users by their main contact email.
  def self.find_by_email email
    contact = Contact.find_by_email(email) or raise ActiveRecord::RecordNotFound
    contact.user
  end
  
  # Returns a user in case one with matching password and username/email exists
  # @param [String] email the user's email address is looked up 
  #                 and matched with the password hash.
  # @param [String] password the clear character password to be matched
  # @return [User] The user, if one is found. Otherwise _nil_ is returned.
  def self.authenticate(username_or_email, password)
    if username_or_email.match  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
      
      
      
      user = User.find_by_email(username_or_email) || Gigauser.find_by_email(username_or_email)

    else
      user = (User.find_by_user_name(username_or_email) || Gigauser.find_by_username(username_or_email)) or raise ActiveRecord::RecordNotFound
    end
    expected_password = encrypted_password(password, user.salt) 
    user.hashed_password == expected_password or raise ActiveRecord::RecordNotFound
    
    return user
  rescue ActiveRecord::RecordNotFound
    nil
  end
  
  # Returns the user remembered in the provided cookie as long as the password
  # (and the salt) haven't changed in the mean time.
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
  
  #Initiates the password reset procedure
  # @param [String] email the email address is looked up in the users database to reset the user’s password.
  # @return [User] The user, eventually with the errors raised by the password reset procedure.
  def self.forgot_password_for(email)
    user = self.find_by_email(email) or raise ActiveRecord::RecordNotFound
    unless user.unverified?
      user.password_reset! if user.create_password_reset_key
    else
      user.errors.add(:email, :has_to_be_verified_to_reset)
    end
    user
  end
  
  def self.find_by_password_reset_token(token)
    key = UserPasswordResetKey.find_by_token(token) or raise ActiveRecord::RecordNotFound
    key.user.password_reset_token = token
    return key.user
  end
  
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
    
  # Builds methods to update, verify or track changes of the user's status, it's based on the
  # STATUSES array.
  def verified!
    update_attribute :status_code, User::STATUSES.index(:verified)
    if    verification_key   then verification_key.destroy; verification_key(true)
    elsif password_reset_key then password_reset_key.destroy; password_reset_key(true)
    end
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
    
    # Ensures the presence of the old password or a password reset token to change
    # the user's password.
    def reset_token_or_old_password
      if self.password_reset_token
        self.verified
        return true
      elsif old_password
        return true if User.encrypted_password(old_password, self.salt_was) == self.hashed_password_was
        errors.add(:old_password, :wrong_password)
      else
        errors.add(:old_password, :old_password_missing)
      end
    end
      
    # Empties the clear password from the user instance variables.
    def delete_clear_password
      @password = nil
      @password_reset_token = nil
    end
    
    #  Used in a callback. Marks the verification_keys if they are present.
    def spend_user_token
      case status_was
      when :unverified     && self.verification_key   then self.verification_key.mark_for_destruction
      when :password_reset && self.password_reset_key then self.password_reset_key.mark_for_destruction
      end
    end
end
