class UserVerificationKey < ActiveRecord::Base
  default_scope where(:password_reset => false)
  
  belongs_to :user
  
  validates_presence_of :user_id
  validates_uniqueness_of :token
  validate :fresh?, :if => :expires?
  
  before_validation :make_token, :on => :create
  
  # Class method to establish if the token has an expiration period.
  def self.fresh_for(time = nil, options = {})
    if time
      @fresh_for = time 
      @expired_message = options[:after]
    end
    @fresh_for
  end
  
  fresh_for 2.weeks
  
  protected
    
    # Creates a token key
    def make_token
      string_to_hash = "#{Time.now}-#{rand}-#{self.user_id}"
      self.token = Digest::SHA1.hexdigest(string_to_hash)
    end

    # Will automatically be validated if is defined.
    def fresh?
      if (self.created_at || Time.now) < self.class.fresh_for.ago
        errors.add(:base, :token_expired)
      end
    end
    
    # Returns true if an expiration has been set for the key
    def expires?
      self.class.fresh_for ? true : false
    end

end