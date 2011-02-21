class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :access, :app
      
      if user.roles.include? :admin
        can :administer, :all
      end
      
      client_privileges if user.account_membership
      
      translator_privileges if user.departements.list.include?(:translator)
      
    else #guest

    end
  end
  
  
  def client_privileges
    can :read, :glossary
  end

end