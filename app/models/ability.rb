class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      @user = user
      
      can :access, :app
      
      if user.roles.include? :admin
        can :manage, :all
      end
      
      # To determine if a user has client privileges in the future just add them to
      # the `current_ability` inside the project controller.
      client_privileges if user.account_membership

      translator_privileges if user.departements.has?(:languages)
      
    else #guest

    end
  end
  
  def client_privileges
    can :manage, :glossary
    can :manage, Sentence
    can :manage, Translation
    can :manage, Comment
    can :manage, Tag
  end
  
  def translator_privileges
    translator = @user.languages
    
    can :read,   :glossary
    can :create, [Sentence, Translation, Comment, Tag]
    
    # A translator can amend or delete his contribution to the glossary in 2 hours 
    can [:update, :destroy], [Sentence, Translation, Comment, Tag] do |glossary_item|
      (glossary_item.author_id == @user.id) &&
      (glossary_item.updated_at > 2.hours.ago)
    end
    
    can :flag, Sentence do |sentence|
      if sentence.flagged?
        @user.id == sentence.flagged_by_id
      else
        true
      end
    end
  end
  
end