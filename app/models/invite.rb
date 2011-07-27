class Invite < ActiveRecord::Base
  belongs_to :sender,    :class_name => "User"
  belongs_to :recipient, :class_name => "Contact"
  
  # validates_uniqueness_of :recipient, :message => 'has already received an invite.'
  belongs_to :gigaclient,:class_name => 'Gigaclient',:foreign_key => 'event_id'
  # validates_uniqueness_of :token
  # validate :recipient_is_not_registered
  
  # validate_on_update :invite_is_fresh?
  
  before_create :generate_token
  
  private
    def recipient_is_not_registered
      errors.add :recipient, 'is already in the program' if recipient.user
    end

    def generate_token
      self.token = Digest::SHA1.hexdigest("#{Time.now}-#{rand}-gigaworx")
    end
  
    def invite_is_fresh?
      errors.add(:created_at, "invite is too old, please contact an administrator") if (self.created_at || Time.now) < 1.month.ago
    end
  
end
