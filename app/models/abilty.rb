class Ability
  include CanCan::Ability

  def initialize(user)
    if user

    else #guest

    end
  end

end