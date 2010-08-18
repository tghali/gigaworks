class ActiveRecord::Base
  # Skips some verifications, useful mostly to skip the beta invite verification process.
  def performed_by_admin
    @performed_by_admin = true
    self
  end
  
  # Overrides some verifications if the the user is being edited in the admin panel
  def performed_by_admin?
    @performed_by_admin ? true : false
  end
end