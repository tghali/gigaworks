class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :access,     :app # TODO: use it to bounce banned users to #forbidden?
      can :administer, :cms if user.roles.include? :admin
      can :administer, :crm if user.roles.include? :admin
    else #guest

    end
  end

end