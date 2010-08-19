class UserPasswordResetKey < UserVerificationKey
  default_scope where(:password_reset => true)
  
  before_validation lambda {|k| k.password_reset = true}, :on => :create
  
  validate :fresh?, :if => :expires?
  
  fresh_for 2.days
  
  validates_presence_of :password_reset
end