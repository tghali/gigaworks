class ClientContactInvite < ActiveRecord::Base
	  belongs_to :sender,    :class_name => "Gigauser"
          belongs_to :recipient, :class_name => "ClientContact"


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
