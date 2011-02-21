module Admin::UsersHelper
  
  def roles_for user
    roles = []
    roles << "admin"       if user.is_admin?
    roles << "client"      if user.is_client? 
    roles << "translator"  if user.departements.has?(:languages)
    roles << "sales rep"   if user.departements.has?(:sales)
    roles << "creative"    if user.departements.has?(:creative)
    
    roles.join " "
  end
  
  
end
