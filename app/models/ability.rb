class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      @user = user
      
      can :access, :app
      
      
    if user.class.to_s == "User"  	     
      if user.roles.include? :admin
        can :manage, :all
      end        
      # To determine if a user has client privileges in the future just add them to
      # the `current_ability` inside the project controller.      
     client_privileges if user.account_membership
     translator_privileges if user.departements.has?(:languages)
    end
     
  

  if user.class.to_s == 'Gigauser' 
      if user.role ==  "Translator" 
        can :access, [Sentence]
      elsif user.role ==  "Editor" 
        can :manage, [Sentence,ManageImage]
        cannot [:delete_sentence,:tag_delete,:delete_translation], Sentence
      elsif user.role ==  "Project Manager" 
        can :manage, [Sentence,Comment,ManageImage]
     elsif user.role == "Client" 
        can :manage, [ClientContact, ClientContactInvite,Sentence,Comment,ManageImage]
     end	   
 end     


      
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